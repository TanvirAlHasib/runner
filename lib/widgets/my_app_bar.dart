import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:runner/constraints/firebase_constants.dart';
import '../constraints/color_constraints.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key});

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Keep the stream instance instead of recreating it on rebuild.
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _unreadNotificationStream = _firebaseFirestore
      .collection(FirebaseConstants.collectionName)
      .doc(_firebaseAuth.currentUser!.uid)
      .collection(FirebaseConstants.notificationCollection)
      .where("isUnread", isEqualTo: true)
      .limit(1)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      elevation: 3,
      title: Text(
        "Runner",
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Color(ColorConstraints.buttonColor),
          fontWeight: FontWeight.w800,
        ),
      ),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            context.pushNamed("notification");
          },
          icon: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _unreadNotificationStream,
            builder: (context, snapshot) {
              // Loading or error state
              if (!snapshot.hasData) {
                return Icon(
                  Icons.notifications_none,
                  color: Color(ColorConstraints.buttonColor),
                );
              }
              // Check whether unread notifications exist
              final hasUnread = snapshot.data!.docs.isNotEmpty;
              return Icon(
                hasUnread ? Icons.notifications_active : Icons.notifications_none,
                color: Color(ColorConstraints.buttonColor),
              );
            },
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.only(right: 8),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}