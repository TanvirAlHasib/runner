import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/constraints/firebase_constants.dart';
import 'package:runner/models/run_details_model.dart';
import '../provider/location_stream.dart';
import '../widgets/run_complete_screen_card.dart';
import '../widgets/run_complete_screen_details.dart';

class RunCompletePreview extends StatefulWidget {
  const RunCompletePreview({super.key, required this.runDetailsModel});
  final RunDetailsModel runDetailsModel;

  @override
  State<RunCompletePreview> createState() => _RunCompletePreviewState();
}

class _RunCompletePreviewState extends State<RunCompletePreview> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  bool isLoading = false;
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
                DetailsCard(detail: "${widget.runDetailsModel.duration} Min", title: "DURATION",),
                DetailsCard(detail: "${widget.runDetailsModel.pace.toStringAsFixed(2)} Min/KM", title: "AVG PACE",),
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
            Row(
              spacing: 10,
              children: [
                Expanded(child: FilledButton(
                  onPressed: () {
                    //canceling the location stream
                    context.read<LocationStream>().cancelStream();
                    // navigating to the home screen
                    context.goNamed("home");
                  },
                  style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Colors.transparent,
                      foregroundColor: Color(ColorConstraints.buttonColor),
                      side: BorderSide(
                          color: Color(ColorConstraints.buttonColor),
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: 2
                      ),
                      textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      )
                  ),
                  child: Text("CANCEL"),
                ),),
                Expanded(child: FilledButton(
                  onPressed: isLoading ? null :() async {
                    try{
                      setState(() {
                        isLoading = true;
                      });
                      await _firebaseFirestore.collection(FirebaseConstants.collectionName).doc("user_gmail")
                          .collection(FirebaseConstants.history).add({
                        "title": widget.runDetailsModel.title,
                        "distance": widget.runDetailsModel.distance,
                        "pace": widget.runDetailsModel.pace,
                        "dateTime": widget.runDetailsModel.dateTime,
                        "duration": widget.runDetailsModel.duration
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data saved successfully!!")));
                      context.goNamed("home");
                    } on FirebaseException catch (e){
                      setState(() {
                        isLoading = false;
                      });
                      if(mounted){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message!)));
                      }
                    } finally{
                      //canceling the location stream
                      context.read<LocationStream>().cancelStream();
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Color(ColorConstraints.buttonColor),
                      foregroundColor: Color(ColorConstraints.splashBackground_0),
                      textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w700
                      )
                  ),
                  child: Text("SAVE"),
                ),),
              ],
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
