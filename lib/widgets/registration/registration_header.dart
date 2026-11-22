import 'package:flutter/material.dart';
import '../../constraints/color_constraints.dart';

class RegistrationHeader extends StatelessWidget {
  const RegistrationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'START YOUR\nJOURNEY.',
          style: TextStyle(
            color: Color(ColorConstraints.headLineFontColor),
            fontSize: 35,
            fontWeight: FontWeight.w900,
            height: 1.15,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Create an account and make every step count.',
          style: TextStyle(
            color: Color(ColorConstraints.bodyFontColor),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
