import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    this.photoURL,
  });

  final String? photoURL;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color(ColorConstraints.buttonColor),
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 48,
        backgroundColor: Color(ColorConstraints.cardColor),
        backgroundImage: photoURL != null && photoURL!.isNotEmpty
            ? NetworkImage(photoURL!)
            : null,
        child: photoURL == null || photoURL!.isEmpty
            ? Icon(
          Icons.person,
          size: 48,
          color: Color(ColorConstraints.buttonColor),
        )
            : null,
      ),
    );
  }
}