import 'package:flutter/material.dart';
import '../../constraints/color_constraints.dart';

class RunnerLogo extends StatelessWidget {
  const RunnerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.directions_run_rounded,
          color: Color(ColorConstraints.buttonColor),
          size: 32,
        ),
        const SizedBox(width: 10),
        Text(
          'RUNNER',
          style: TextStyle(
            color: Color(ColorConstraints.buttonColor),
            fontSize: 21,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
