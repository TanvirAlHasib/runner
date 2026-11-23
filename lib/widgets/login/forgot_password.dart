import 'package:flutter/material.dart';
import '../../constraints/color_constraints.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onPressed;

  const ForgotPassword({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Color(ColorConstraints.buttonColor),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}