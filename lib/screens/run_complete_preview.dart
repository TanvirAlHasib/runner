import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/models/run_details_model.dart';
import '../widgets/run_complete_screen_card.dart';
import '../widgets/run_complete_screen_details.dart';

class RunCompletePreview extends StatefulWidget {
  const RunCompletePreview({super.key, required this.runDetailsModel});
  final RunDetailsModel runDetailsModel;

  @override
  State<RunCompletePreview> createState() => _RunCompletePreviewState();
}

class _RunCompletePreviewState extends State<RunCompletePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(ColorConstraints.backGroundColor),
              Color(ColorConstraints.splashBackground_0)
            ],
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.bottomCenter
          )
        ),
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .center,
          children: [
            RunCompleteScreenCard(
              shadowColor: Color(ColorConstraints.buttonColor),
              child: Lottie.asset("lib/assets/animations/walking_avocado.json", height: 80,
                fit: BoxFit.cover,),
            ),
            const SizedBox(
              height: 25,
            ),
            Text("Run Completed", style: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontWeight: FontWeight.w700,
              color: Color(ColorConstraints.headLineFontColor)
            ),),
            const SizedBox(
              height: 3,
            ),
            Text("Run daily to maintain your lungs health", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(ColorConstraints.bodyFontColor),
            ),),
            const SizedBox(
              height: 10,
            ),
            RunCompleteScreenCard(
              shadowColor: Color(ColorConstraints.buttonColor),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("${widget.runDetailsModel.distance} KM", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Color(ColorConstraints.buttonColor),
                  fontWeight: FontWeight.w600
                ),),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisSize: .min,
              children: [
                DetailsCard(detail: "${widget.runDetailsModel.duration}", title: "DURATION",),
                DetailsCard(detail: "${widget.runDetailsModel.pace}", title: "AVG PACE",),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Lottie.asset("lib/assets/animations/spin.json"),
            ),
          ],
        ),
      ),
    );
  }
}
