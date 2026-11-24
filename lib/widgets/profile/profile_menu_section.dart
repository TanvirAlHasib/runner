import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'profile_menu_item.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({
    super.key,
    required this.onPersonalInfo,
    required this.onSettings,
    required this.onHelp,
  });

  final VoidCallback onPersonalInfo;
  final VoidCallback onSettings;
  final VoidCallback onHelp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ACCOUNT",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Color(ColorConstraints.headLineFontColor),
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),

        const SizedBox(height: 14),

        ProfileMenuItem(
          icon: Icons.person_outline,
          title: "Personal Information",
          subtitle: "Manage your personal details",
          onTap: onPersonalInfo,
        ),

        ProfileMenuItem(
          icon: Icons.settings_outlined,
          title: "App Settings",
          subtitle: "Customize your experience",
          onTap: onSettings,
        ),

        ProfileMenuItem(
          icon: Icons.help_outline,
          title: "Help & Support",
          subtitle: "Get assistance",
          onTap: onHelp,
        ),
      ],
    );
  }
}