import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';
import 'services/supabase_service.dart';
import 'repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('APP STARTED (main() reached)');


  // Load environment variables (do not crash the app if .env is missing)
  String supabaseUrl = '';
  String supabaseAnonKey = '';

  try {
    await dotenv.load(fileName: '.env');
    // Only access dotenv.env after successful load()
    supabaseUrl = (dotenv.env['SUPABASE_URL'] ?? '').trim();
    supabaseAnonKey = (dotenv.env['SUPABASE_ANON_KEY'] ?? '').trim();
  } catch (e) {
    // .env might not exist in all environments (e.g. CI, release). We'll keep credentials empty.
    debugPrint('dotenv.load failed: $e');
  }

  // Initialize Supabase


  final supabaseService = SupabaseService();
  try {
    debugPrint('Supabase URL loaded: ${supabaseUrl.isNotEmpty}');
    debugPrint('Supabase anon key loaded: ${supabaseAnonKey.isNotEmpty}');

    if (supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty) {
      await supabaseService.initialize(
        supabaseUrl: supabaseUrl,
        supabaseAnonKey: supabaseAnonKey,
      );
      debugPrint('SupabaseService initialize() completed');
    } else {
      debugPrint(
        'Missing Supabase credentials (SUPABASE_URL / SUPABASE_ANON_KEY). '
        'Create a .env file with these keys to enable authentication.',
      );
    }
  } catch (e, st) {

    debugPrint('Supabase initialization failed: $e');
    debugPrintStack(stackTrace: st);
    // IMPORTANT: still continue to UI.
  }


  runApp(
    MultiProvider(
      providers: [
        Provider<SupabaseService>(create: (_) => supabaseService),
        Provider<AuthRepository>(
          create: (context) => AuthRepository(supabaseService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'e-TODAmo',
      theme: ThemeData(
        primaryColor: const Color(0xFF1565C0),
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
