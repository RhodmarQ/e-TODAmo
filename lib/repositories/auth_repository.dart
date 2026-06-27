import '../models/user.dart';
import '../services/supabase_service.dart';

class AuthRepository {
  final SupabaseService _supabaseService;

  AuthRepository(this._supabaseService);

  /// Register new user
  Future<User> register({
    required String email,
    required String password,
    required String username,
    required String userType,
    required String birthDate,
  }) async {
    return await _supabaseService.registerUser(
      email: email,
      password: password,
      username: username,
      userType: userType,
      birthDate: birthDate,
    );
  }

  /// Login user
  Future<User> login({
    required String email,
    required String password,
  }) async {
    return await _supabaseService.loginUser(
      email: email,
      password: password,
    );
  }

  /// Logout user
  Future<void> logout() async {
    return await _supabaseService.logoutUser();
  }

  /// Check if user is logged in
  bool isLoggedIn() {
    return _supabaseService.isLoggedIn();
  }

  /// Get current user
  User? getCurrentUser() {
    return _supabaseService.currentUser;
  }

  /// Update user profile
  Future<User> updateProfile({
    required String userId,
    String? username,
    String? birthDate,
  }) async {
    return await _supabaseService.updateUserProfile(
      userId: userId,
      username: username,
      birthDate: birthDate,
    );
  }

  /// Check if username exists
  Future<bool> usernameExists(String username) async {
    return await _supabaseService.usernameExists(username);
  }

  /// Check if email exists
  Future<bool> emailExists(String email) async {
    return await _supabaseService.emailExists(email);
  }
}
