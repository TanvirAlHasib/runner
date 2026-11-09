import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/models/run_details_model.dart';

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
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      appBar: myAppBar(context),
    );
  }

  // app bar code
  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      elevation: 3,
      title: Text("Runner", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Color(ColorConstraints.buttonColor),
          fontWeight: FontWeight.w800
      ),),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_none, color: Color(ColorConstraints.buttonColor)),
        )
      ],
      actionsPadding: const EdgeInsets.only(right: 8),
    );
  }
}
