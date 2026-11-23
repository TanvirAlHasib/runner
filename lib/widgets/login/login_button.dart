import 'package:flutter/material.dart';
import '../../constraints/color_constraints.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const LoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(ColorConstraints.buttonColor),
          foregroundColor: Color(ColorConstraints.buttonFontColor),
          disabledBackgroundColor:
          Color(ColorConstraints.buttonColor).withValues(alpha: 0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: 23,
          width: 23,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            color: Color(ColorConstraints.buttonFontColor),
          ),
        )
            : const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_rounded),
          ],
        ),
      ),
    );
  }
}