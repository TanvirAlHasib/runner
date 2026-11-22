import 'package:flutter/material.dart';
import '../../constraints/color_constraints.dart';

class LoginRedirect extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginRedirect({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 14),
            children: [
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: Color(ColorConstraints.bodyFontColor),
                ),
              ),
              TextSpan(
                text: 'Login',
                style: TextStyle(
                  color: Color(ColorConstraints.buttonColor),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}