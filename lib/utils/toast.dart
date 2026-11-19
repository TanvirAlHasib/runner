import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:runner/constraints/color_constraints.dart';

class Toast {
  static void showMessage({required String body, required BuildContext context}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        spacing: 5,
        children: [
          Lottie.asset("lib/assets/animations/walking_avocado.json", height: 45, width: 45, fit: BoxFit.cover),
          Text(body, maxLines: 1, overflow: TextOverflow.fade, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w600,
            color: Color(ColorConstraints.bodyFontColor)
          ),)
        ],
      ),
      closeIconColor: Color(ColorConstraints.buttonColor),
      backgroundColor: Color(ColorConstraints.splashBackground_1),
      showCloseIcon: true,
    ));
  }
}