import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/constraints/firebase_constants.dart';
import 'package:runner/widgets/profile/profile_header.dart';
import 'package:runner/widgets/profile/running_stats_section.dart';
import 'package:runner/widgets/profile/profile_menu_section.dart';
import 'package:runner/widgets/profile/profile_logout_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

    return Scaffold(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              StreamBuilder(
                stream: _firebaseFirestore.collection(FirebaseConstants.collectionName).doc(user?.uid)
                  .collection(FirebaseConstants.user).snapshots(),
                builder: (context, asyncSnapshot) {

                  if(asyncSnapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  final userData = asyncSnapshot.data?.docs.first.data();
                  return ProfileHeader(
                    username: userData?["username"] ?? "Runner",
                    email: userData?["email"] ?? "No email available",
                    photoURL: userData?["photoURL"],
                    onEditProfile: () {
                      //context.pushNamed("editProfile");
                    },
                    onSettings: () {
                      //context.pushNamed("settings");
                    },
                  );
                }
              ),

              const SizedBox(height: 35),

              RunningStatsSection(),

              const SizedBox(height: 35),

              ProfileMenuSection(
                onPersonalInfo: () {
                  //context.pushNamed("editProfile");
                },
                onSettings: () {
                  //context.pushNamed("settings");
                },
                onHelp: () {
                  // Navigate to help screen
                },
              ),

              const SizedBox(height: 20),

              ProfileLogoutButton(
                onLogout: () async {
                  await FirebaseAuth.instance.signOut();

                  if (context.mounted) {
                    context.goNamed("login");
                  }
                },
              ),

              const SizedBox(height: 25),

              Text(
                "RUNNER • KEEP MOVING FORWARD",
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  color: Color(ColorConstraints.bodyFontColor).withValues(alpha: 0.6),
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}