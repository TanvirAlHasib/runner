import 'package:flutter/material.dart';
import '../constraints/color_constraints.dart';

class RunCompleteScreenCard extends StatelessWidget {
  const new({
    super.key,
    required this.child, this.elevation = 2, required this.shadowColor
  });

  final Widget child;
  final double? elevation;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return Card.filled(
        elevation: elevation,
        shadowColor: shadowColor,
        color: Color(ColorConstraints.backGroundColor),
        child: child
    );
  }
}