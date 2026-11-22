import 'package:flutter/material.dart';
import '../../constraints/color_constraints.dart';

class RegistrationTextField extends StatelessWidget {

  const RegistrationTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(ColorConstraints.headLineFontColor),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 9),
        TextFormField(
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: Color(ColorConstraints.headLineFontColor),
            fontSize: 15,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Color(ColorConstraints.bodyFontColor),
              fontSize: 14,
            ),
            prefixIcon: Icon(
              icon,
              color: Color(ColorConstraints.bodyFontColor),
              size: 20,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Color(ColorConstraints.cardColor).withValues(alpha: 0.45),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Color(ColorConstraints.buttonColor).withValues(alpha: 0.12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Color(ColorConstraints.buttonColor),
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
