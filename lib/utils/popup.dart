import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:runner/constraints/color_constraints.dart';

class Popup {
  static void showPopUp(BuildContext context){
    showAdaptiveDialog(context: context, builder: (context) {
      return AlertDialog(
        backgroundColor: Color(ColorConstraints.backGroundColor),
        title: Row(
          mainAxisSize: .min,
          children: [
            LottieBuilder.asset("lib/assets/animations/walking_avocado.json", height: 25, width: 25,),
            Text("Alert!!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(ColorConstraints.buttonColor),
            ),)
          ],
        ),
        content: Text("Are you running? If not then finish the run, please", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Color(ColorConstraints.bodyFontColor)
        ),),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Ok", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Color(ColorConstraints.buttonColor)
          ),))
        ],
      );
    },);
  }
}