import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../constraints/color_constraints.dart';
import '../../widgets/registration/runner_logo.dart';
import '../../widgets/registration/registration_text_field.dart';
import '../../widgets/login/forgot_password.dart';
import '../../widgets/login/login_button.dart';
import '../../widgets/login/google_login_button.dart';
import '../../widgets/login/registration_redirect.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (!_formKey.currentState!.validate()) return;

    // Connect your login API/Firebase here.
  }

  void googleLogin() {
    // Implement Google authentication here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 25,
              vertical: 25,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Logo
                  const RunnerLogo(),

                  const SizedBox(height: 55),

                  // Header
                  Text(
                    'WELCOME\nBACK.',
                    style: TextStyle(
                      color: Color(
                        ColorConstraints.headLineFontColor,
                      ),
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      height: 1.15,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Ready for another run? Let’s get moving.',
                    style: TextStyle(
                      color: Color(ColorConstraints.bodyFontColor),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Email
                  RegistrationTextField(
                    label: 'Email Address',
                    hint: 'example@email.com',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }

                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 22),

                  // Password
                  RegistrationTextField(
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Color(
                          ColorConstraints.bodyFontColor,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 18),

                  // Forgot Password
                  ForgotPassword(
                    onPressed: () {
                      // Navigate to ForgotPasswordScreen
                    },
                  ),

                  const SizedBox(height: 30),

                  // Login
                  LoginButton(
                    onPressed: login,
                    isLoading: _isLoading,
                  ),

                  const SizedBox(height: 25),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Color(
                            ColorConstraints.bodyFontColor,
                          ).withValues(alpha: 0.25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Color(
                              ColorConstraints.bodyFontColor,
                            ),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(
                            ColorConstraints.bodyFontColor,
                          ).withValues(alpha: 0.25),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // Google Login
                  GoogleLoginButton(
                    onPressed: googleLogin,
                  ),

                  const SizedBox(height: 35),

                  // Registration redirect
                  RegistrationRedirect(
                    onPressed: () {
                      // Navigate to RegistrationScreen
                      context.pushNamed("registration");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}