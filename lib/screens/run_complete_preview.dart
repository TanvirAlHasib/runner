import 'package:flutter/material.dart';
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
      body: Center(
        child: Text("${widget.runDetailsModel.dateTime}"),
      ),
    );
  }
}
