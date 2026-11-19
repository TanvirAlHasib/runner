import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:runner/constraints/color_constraints.dart';

class Toast {
  void showMessage({required String title, required String body, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        spacing: 5,
        children: [
          Lottie.asset("lib/assets/animations/walking_avocado.json", height: 25, width: 25, fit: BoxFit.cover),
          Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: Color(ColorConstraints.bodyFontColor)
          ),)
        ],
      ),
      closeIconColor: Color(ColorConstraints.buttonColor),
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      showCloseIcon: true,
    ));
  }
}