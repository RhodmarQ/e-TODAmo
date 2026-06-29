import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositories/auth_repository.dart';

class RegisterFormPage extends StatefulWidget {
  final String userType;

  const RegisterFormPage({
    super.key,
    required this.userType,
  });

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  String? _selectedMonth;
  String? _selectedDay;
  String? _selectedYear;

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1565C0),
              Color(0xFF0D47A1),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xFF42A5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.directions_bike,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'e-TODA',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                      TextSpan(
                        text: 'mo',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Register',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _usernameController,
                        enabled: !_isLoading,
                        decoration: InputDecoration(
                          hintText: 'Input Username',
                          hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        enabled: !_isLoading,
                        decoration: InputDecoration(
                          hintText: 'Input Email',
                          hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        enabled: !_isLoading,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          hintText: 'Input Password',
                          hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xFF757575),
                            ),
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _confirmPasswordController,
                        enabled: !_isLoading,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Input Password again',
                          hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color(0xFF757575),
                            ),
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        'Birthdate',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Month'),
                              value: _selectedMonth,
                              items: months
                                  .map((month) => DropdownMenuItem(
                                        value: month,
                                        child: Text(month),
                                      ))
                                  .toList(),
                              onChanged: _isLoading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedMonth = value;
                                      });
                                    },
                              underline: Container(
                                color: const Color(0xFFBDBDBD),
                                height: 1,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Date'),
                              value: _selectedDay,
                              items: List.generate(31, (index) {
                                final day = (index + 1).toString();
                                return DropdownMenuItem(
                                  value: day,
                                  child: Text(day),
                                );
                              }).toList(),
                              onChanged: _isLoading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedDay = value;
                                      });
                                    },
                              underline: Container(
                                color: const Color(0xFFBDBDBD),
                                height: 1,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text('Year'),
                              value: _selectedYear,
                              items: List.generate(100, (index) {
                                final year =
                                    (DateTime.now().year - index).toString();
                                return DropdownMenuItem(
                                  value: year,
                                  child: Text(year),
                                );
                              }).toList(),
                              onChanged: _isLoading
                                  ? null
                                  : (value) {
                                      setState(() {
                                        _selectedYear = value;
                                      });
                                    },
                              underline: Container(
                                color: const Color(0xFFBDBDBD),
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  final username =
                                      _usernameController.text.trim();
                                  final email = _emailController.text.trim();
                                  final password = _passwordController.text;
                                  final confirmPassword =
                                      _confirmPasswordController.text;

                                  if (username.isEmpty ||
                                      email.isEmpty ||
                                      password.isEmpty ||
                                      confirmPassword.isEmpty ||
                                      _selectedMonth == null ||
                                      _selectedDay == null ||
                                      _selectedYear == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please fill in all fields'),
                                      ),
                                    );
                                    return;
                                  }

                                  if (password != confirmPassword) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Passwords do not match'),
                                      ),
                                    );
                                    return;
                                  }

                                  setState(() {
                                    _isLoading = true;
                                  });

                                  final authRepository =
                                      context.read<AuthRepository>();

                                  final monthIndex =
                                      months.indexOf(_selectedMonth!);
                                  final month = (monthIndex + 1)
                                      .toString()
                                      .padLeft(2, '0');
                                  final day = _selectedDay!.padLeft(2, '0');
                                  final year = _selectedYear!;
                                  final birthDateIso = '$year-$month-$day';

                                  try {
                                    await authRepository.register(
                                      email: email,
                                      password: password,
                                      username: username,
                                      userType: widget.userType,
                                      birthDate: birthDateIso,
                                    );

                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Registration successful (${widget.userType})',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );

                                    Navigator.pop(context);
                                  } catch (e) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          e.toString().replaceFirst(
                                                'Exception: ',
                                                '',
                                              ),
                                        ),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1565C0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Register now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
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
    );
  }
}

