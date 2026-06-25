import 'package:flutter/material.dart';

void main() {
  runApp(const ETODAMoApp());
}

class ETODAMoApp extends StatelessWidget {
  const ETODAMoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const _NoOverscrollScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'E-TODAMo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromARGB(255, 23, 207, 78),
        scaffoldBackgroundColor: const Color(0xFFEFF5FF),
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (_) => const HomePage(),
        LoginOptionPage.routeName: (_) => const LoginOptionPage(),
        RegisterOptionPage.routeName: (_) => const RegisterOptionPage(),
        PassengerLoginPage.routeName: (_) =>
            const AuthPage(args: AuthPageArgs(mode: AuthMode.login, role: UserRole.passenger)),
        DriverLoginPage.routeName: (_) =>
            const AuthPage(args: AuthPageArgs(mode: AuthMode.login, role: UserRole.driver)),
        PassengerRegisterPage.routeName: (_) =>
            const AuthPage(args: AuthPageArgs(mode: AuthMode.register, role: UserRole.passenger)),
        DriverRegisterPage.routeName: (_) =>
            const AuthPage(args: AuthPageArgs(mode: AuthMode.register, role: UserRole.driver)),
      },
    );
  }
}

enum AuthMode { login, register }

enum UserRole { passenger, driver }

class AuthPageArgs {
  final AuthMode mode;
  final UserRole role;

  const AuthPageArgs({required this.mode, required this.role});
}

class HomePage extends StatelessWidget {
  static const routeName = '/';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Positioned.fill(child: _BackgroundDecoration()),
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 40),
                      const _AppBrand(shadow: false),
                      const SizedBox(height: 50),
                      const Text(
                        'Fast, Safe and Reliable\nTricycle Services',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 42),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2358FF),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.login, size: 22),
                        label: const Text('Log In', style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          Navigator.pushNamed(context, LoginOptionPage.routeName);
                        },
                      ),
                      const SizedBox(height: 18),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B7BFF),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.person_add, size: 22),
                        label: const Text('Create Account', style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          Navigator.pushNamed(context, RegisterOptionPage.routeName);
                        },
                      ),
                      const SizedBox(height: 28),
                      const Text(
                        'or',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color.fromARGB(179, 0, 0, 0)),
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: Color.fromARGB(137, 0, 0, 0), thickness: 1.2),
                      const SizedBox(height: 18),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.admin_panel_settings, color: Color.fromARGB(179, 0, 0, 0), size: 18),
                          SizedBox(width: 10),
                          Text('Admin Login',
                              style: TextStyle(color: Color.fromARGB(179, 0, 0, 0), fontSize: 14)),
                        ],
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginOptionPage extends StatelessWidget {
  static const routeName = '/login-option';

  const LoginOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthOptionScaffold(
      title: 'Log In As',
      subtitle: 'Choose your role to continue',
      cards: [
        RoleCard(
          role: UserRole.passenger,
          title: 'Passenger',
          description: 'Book a ride, track your driver, and reach your destination.',
          icon: Icons.person_outline,
          onTap: () {
            Navigator.pushNamed(context, PassengerLoginPage.routeName);
          },
        ),
        RoleCard(
          role: UserRole.driver,
          title: 'Driver',
          description: 'Accept bookings, manage trips, and grow your earnings.',
          icon: Icons.delivery_dining,
          onTap: () {
            Navigator.pushNamed(context, DriverLoginPage.routeName);
          },
        ),
      ],
    );
  }
}

class RegisterOptionPage extends StatelessWidget {
  static const routeName = '/register-option';

  const RegisterOptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthOptionScaffold(
      title: 'Register As',
      subtitle: 'Select a profile to create an account',
      cards: [
        RoleCard(
          role: UserRole.passenger,
          title: 'Passenger',
          description: 'Ride with comfort and pay effortlessly for every trip.',
          icon: Icons.person_outline,
          onTap: () {
            Navigator.pushNamed(context, PassengerRegisterPage.routeName);
          },
        ),
        RoleCard(
          role: UserRole.driver,
          title: 'Driver',
          description: 'Manage your schedule, earn more, and stay on the road.',
          icon: Icons.delivery_dining,
          onTap: () {
            Navigator.pushNamed(context, DriverRegisterPage.routeName);
          },
        ),
      ],
    );
  }
}

class AuthOptionScaffold extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Widget> cards;

  const AuthOptionScaffold({super.key, required this.title, required this.subtitle, required this.cards});

  @override
  State<AuthOptionScaffold> createState() => _AuthOptionScaffoldState();
}

class _AuthOptionScaffoldState extends State<AuthOptionScaffold> {
  final GlobalKey _contentKey = GlobalKey();
  bool _needsScroll = true;

  void _measure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _contentKey.currentContext;
      if (ctx == null) return;
      final size = ctx.size;
      if (size == null) return;
      final viewport = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.vertical;
      final needs = size.height > viewport;
      if (needs != _needsScroll) setState(() => _needsScroll = needs);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _measure());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _measure();
  }

  @override
  Widget build(BuildContext context) {
    final content = ConstrainedBox(
      key: _contentKey,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const _AppBrand(shadow: false),
            const SizedBox(height: 28),
            Text(widget.title,
                style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(widget.subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 30),
            ...widget.cards.map(
              (card) => Padding(padding: const EdgeInsets.only(bottom: 18), child: card),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Positioned.fill(child: _BackgroundDecoration()),
          SafeArea(
            child: _needsScroll
                ? SingleChildScrollView(physics: const ClampingScrollPhysics(), child: content)
                : content,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white.withOpacity(0.16),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacementNamed(context, HomePage.routeName);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoleCard extends StatelessWidget {
  final UserRole role;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.role,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFECF2FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: const Color(0xFF2358FF), size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Text(description,
                        style: const TextStyle(fontSize: 14, color: Colors.black87)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Color(0xFF2358FF), size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PassengerLoginPage extends StatelessWidget {
  static const routeName = '/login-passenger';

  const PassengerLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage(args: AuthPageArgs(mode: AuthMode.login, role: UserRole.passenger));
  }
}

class DriverLoginPage extends StatelessWidget {
  static const routeName = '/login-driver';

  const DriverLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage(args: AuthPageArgs(mode: AuthMode.login, role: UserRole.driver));
  }
}

class PassengerRegisterPage extends StatelessWidget {
  static const routeName = '/register-passenger';

  const PassengerRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage(args: AuthPageArgs(mode: AuthMode.register, role: UserRole.passenger));
  }
}

class DriverRegisterPage extends StatelessWidget {
  static const routeName = '/register-driver';

  const DriverRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthPage(args: AuthPageArgs(mode: AuthMode.register, role: UserRole.driver));
  }
}

class AuthPage extends StatefulWidget {
  static const routeName = '/auth-page';

  final AuthPageArgs args;

  const AuthPage({super.key, required this.args});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _selectedMonth = 'Month';
  String _selectedDay = 'Day';
  String _selectedYear = 'Year';

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRegister = widget.args.mode == AuthMode.register;
    final pageTitle = isRegister ? 'Register' : 'Login';

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const Positioned.fill(child: _BackgroundDecoration()),
          SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 24),
                    const _AppBrand(shadow: false),
                    const SizedBox(height: 22),
                    Text(
                      pageTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              filled: true,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              filled: true,
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              filled: true,
                            ),
                            obscureText: true,
                          ),
                          if (isRegister) ...[
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: const InputDecoration(
                                labelText: 'Confirm Password',
                                filled: true,
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 12),
                            _DatePickerRow(
                              month: _selectedMonth,
                              day: _selectedDay,
                              year: _selectedYear,
                              onChanged: ({month, day, year}) {
                                if (month != null) _selectedMonth = month;
                                if (day != null) _selectedDay = day;
                                if (year != null) _selectedYear = year;
                              },
                            ),
                          ],
                          const SizedBox(height: 18),
                          SizedBox(
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  // Placeholder for auth logic.
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(isRegister ? 'Registered as ${widget.args.role}' : 'Logged in as ${widget.args.role}'),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2358FF),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              ),
                              child: Text(isRegister ? 'Register now' : 'Log In'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white.withOpacity(0.16),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      } else {
                        Navigator.pushReplacementNamed(context, HomePage.routeName);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DatePickerRow extends StatelessWidget {
  final String month;
  final String day;
  final String year;
  final void Function({String? month, String? day, String? year}) onChanged;

  const _DatePickerRow({
    required this.month,
    required this.day,
    required this.year,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: month,
            decoration: const InputDecoration(filled: true, labelText: 'Month'),
            items: const [
              'Month',
              'Jan',
              'Feb',
              'Mar',
              'Apr',
              'May',
              'Jun',
              'Jul',
              'Aug',
              'Sep',
              'Oct',
              'Nov',
              'Dec',
            ]
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => onChanged(month: v),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: day,
            decoration: const InputDecoration(filled: true, labelText: 'Day'),
            items: const ['Day', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => onChanged(day: v),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: year,
            decoration: const InputDecoration(filled: true, labelText: 'Year'),
            items: const ['Year', '2000', '2001', '2002', '2003', '2004']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => onChanged(year: v),
          ),
        ),
      ],
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  const _BackgroundDecoration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D4BFF), Color(0xFF00C853)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class _AppBrand extends StatelessWidget {
  final bool shadow;

  const _AppBrand({required this.shadow});

  @override
  Widget build(BuildContext context) {
    return Text(
      'E-TODAMo',
      style: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        shadows: shadow
            ? [
                const Shadow(
                  blurRadius: 18,
                  offset: Offset(0, 8),
                  color: Colors.black26,
                )
              ]
            : const [],
      ),
    );
  }
}

class _NoOverscrollScrollBehavior extends ScrollBehavior {
  const _NoOverscrollScrollBehavior();

  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

