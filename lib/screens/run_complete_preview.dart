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
        padding: const EdgeInsetsGeometry.all(10),
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
            Spacer(flex: 2,),
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                child: Text("${widget.runDetailsModel.distance.toStringAsFixed(2)} KM", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
            const SizedBox(
              height: 30,
            ),
            FilledButton(
              onPressed: () {

              },
              style: FilledButton.styleFrom(
                minimumSize: Size.fromHeight(60),
                backgroundColor: Color(ColorConstraints.buttonColor),
                foregroundColor: Color(ColorConstraints.splashBackground_0),
                textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w700
                )
              ),
              child: Text("SAVE RUN"),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
