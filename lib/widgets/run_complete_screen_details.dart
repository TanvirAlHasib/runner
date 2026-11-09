import 'package:flutter/material.dart';
import 'package:runner/widgets/run_complete_screen_card.dart';
import '../constraints/color_constraints.dart';

class DetailsCard extends StatelessWidget {
  const new({
    super.key,
    required this.detail,
    required this.title
  });

  final String detail;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: RunCompleteScreenCard(
      elevation: 0,
      shadowColor: Color(ColorConstraints.splashBackground_0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Color(ColorConstraints.bodyFontColor)
            ),),
            Text(detail, style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Color(ColorConstraints.headLineFontColor),
                fontSize: 18,
                fontWeight: FontWeight.w600
            ),),
          ],
        ),
      ),
    )
    );
  }
}