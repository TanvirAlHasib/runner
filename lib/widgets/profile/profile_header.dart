import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'profile_avatar.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.username,
    required this.email,
    this.photoURL,
    required this.onEditProfile,
    required this.onSettings,
  });

  final String username;
  final String email;
  final String? photoURL;
  final VoidCallback onEditProfile;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "MY PROFILE",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Color(ColorConstraints.headLineFontColor),
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            IconButton(
              onPressed: onSettings,
              icon: Icon(
                Icons.settings_outlined,
                color: Color(ColorConstraints.buttonColor),
              ),
            ),
          ],
        ),

        const SizedBox(height: 25),

        ProfileAvatar(photoURL: photoURL),

        const SizedBox(height: 15),

        Text(
          username,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Color(ColorConstraints.headLineFontColor),
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          email,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Color(ColorConstraints.bodyFontColor),
          ),
        ),

        const SizedBox(height: 16),

        OutlinedButton.icon(
          onPressed: onEditProfile,
          icon: const Icon(Icons.edit_outlined, size: 17),
          label: const Text("Edit Profile"),
          style: OutlinedButton.styleFrom(
            foregroundColor: Color(ColorConstraints.buttonColor),
            side: BorderSide(
              color: Color(ColorConstraints.buttonColor),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}