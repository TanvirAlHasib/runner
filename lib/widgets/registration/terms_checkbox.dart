import 'package:flutter/material.dart';
import '../../constraints/color_constraints.dart';

class TermsCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const TermsCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          activeColor: Color(ColorConstraints.buttonColor),
          checkColor: Color(ColorConstraints.buttonFontColor),
          side: BorderSide(
            color: Color(ColorConstraints.bodyFontColor),
          ),
          onChanged: onChanged,
        ),
        Expanded(
          child: Text(
            'I agree to the Terms & Conditions and Privacy Policy.',
            style: TextStyle(
              color: Color(ColorConstraints.bodyFontColor),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}