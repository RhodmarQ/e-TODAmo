import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import '../models/user.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() {
    return _instance;
  }

  SupabaseService._internal();

  SupabaseClient? _supabase;

  SupabaseClient get supabase {
    final client = _supabase;
    if (client == null) {
      throw StateError(
        'SupabaseService not initialized. Call initialize() first. '
        '(Check .env loading + Supabase initialization in lib/main.dart)',
      );
    }
    return client;
  }
  User? _currentUser;

  User? get currentUser => _currentUser;

  /// Initialize Supabase connection
  Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    final url = supabaseUrl.trim();
    final key = supabaseAnonKey.trim();

    if (url.isEmpty || key.isEmpty) {
      throw ArgumentError('Supabase URL/Anon key are empty');
    }

    await Supabase.initialize(
      url: url,
      publishableKey: key,
    );
    _supabase = Supabase.instance.client;
  }

  /// Register a new user
  Future<User> registerUser({
    required String email,
    required String password,
    required String username,
    required String userType,
    required String birthDate,
  }) async {
    try {
      // Register with Supabase Auth
      final authResponse = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Failed to create auth user');
      }

      // Create user profile in database
      final userId = authResponse.user!.id;
      final userMap = {
        'id': userId,
        'username': username,
        'email': email,
        'user_type': userType,
        'birth_date': birthDate,
        'created_at': DateTime.now().toIso8601String(),
      };

      await _supabase!.from('users').insert(userMap);

      _currentUser = User.fromJson(userMap);
      return _currentUser!;

    } on AuthException catch (e) {
      final text = e.toString().toLowerCase().replaceAll('_', ' ');
      if (text.contains('rate limit') ||
          text.contains('too many requests') ||
          text.contains('429') ||
          text.contains('exceeded')) {
        throw Exception(
            'Email rate limit reached. Please wait 5–10 minutes, then try again.');
      }
      throw Exception('Auth error: ${e.message}');
    } catch (e) {
      final s = e.toString().toLowerCase().replaceAll('_', ' ');
      if (s.contains('rate limit') ||
          s.contains('too many requests') ||
          s.contains('429') ||
          s.contains('exceeded')) {
        throw Exception(
            'Email rate limit reached. Please wait 5–10 minutes, then try again.');
      }
      throw Exception('Registration error: $e');
    }
  }

  /// Login user
  Future<User> loginUser({
    required String email,
    required String password,
  }) async {
    // Avoid hard crash if initialize() wasn't completed.
    if (_supabase == null) {
      throw StateError('SupabaseService not initialized. Check .env and lib/main.dart initialization.');
    }

    try {
      // Sign in with Supabase Auth
      final authResponse = await _supabase!.auth.signInWithPassword(
        email: email,
        password: password,
      );


      if (authResponse.user == null) {
        throw Exception('Login failed');
      }

      // Fetch user profile from database
      final userId = authResponse.user!.id;
      final response =
          await _supabase!.from('users').select().eq('id', userId).single();


      _currentUser = User.fromJson(response);
      return _currentUser!;
    } on AuthException catch (e) {
      throw Exception('Auth error: ${e.message}');
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  /// Logout user
  Future<void> logoutUser() async {
    try {
      if (_supabase == null) {
        throw StateError('SupabaseService not initialized. Call initialize() first.');
      }
      await _supabase!.auth.signOut();
      _currentUser = null;
    } catch (e) {
      throw Exception('Logout error: $e');
    }
  }


  /// Check if user is logged in
  bool isLoggedIn() {
    // Avoid throwing before initialize(); return false until Supabase is ready.
    final client = _supabase;
    if (client == null) return false;
    return client.auth.currentUser != null;
  }


  /// Get current session
  Session? getCurrentSession() {
    final client = _supabase;
    if (client == null) return null;
    return client.auth.currentSession;
  }


  /// Update user profile
  Future<User> updateUserProfile({
    required String userId,
    String? username,
    String? birthDate,
  }) async {
    try {
      final updateMap = <String, dynamic>{
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (username != null) {
        updateMap['username'] = username;
      }
      if (birthDate != null) {
        updateMap['birth_date'] = birthDate;
      }

      if (_supabase == null) {
        throw StateError('SupabaseService not initialized. Call initialize() first.');
      }

      await _supabase!.from('users').update(updateMap).eq('id', userId);

      // Fetch updated user
      final response = await _supabase!
          .from('users')
          .select()
          .eq('id', userId)
          .single();


      _currentUser = User.fromJson(response);
      return _currentUser!;
    } catch (e) {
      throw Exception('Profile update error: $e');
    }
  }

  /// Get user by ID
  Future<User> getUserById(String userId) async {
    try {
      if (_supabase == null) {
        throw StateError('SupabaseService not initialized. Call initialize() first.');
      }

      final response = await _supabase!
          .from('users')
          .select()
          .eq('id', userId)
          .single();

      return User.fromJson(response);

    } catch (e) {
      throw Exception('Error fetching user: $e');
    }
  }

  /// Check if username exists
  Future<bool> usernameExists(String username) async {
    try {
      if (_supabase == null) {
        throw StateError('SupabaseService not initialized. Call initialize() first.');
      }

      final response = await _supabase!
          .from('users')
          .select()
          .eq('username', username);


      return response.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking username: $e');
    }
  }

  /// Check if email exists
  Future<bool> emailExists(String email) async {
    try {
      if (_supabase == null) {
        throw StateError('SupabaseService not initialized. Call initialize() first.');
      }

      final response =
          await _supabase!.from('users').select().eq('email', email);



      return response.isNotEmpty;
    } catch (e) {
      throw Exception('Error checking email: $e');
    }
  }
}

