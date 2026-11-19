import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/constraints/firebase_constants.dart';
import 'package:runner/utils/toast.dart';
import 'package:runner/widgets/notification/notification_tile.dart';
import 'package:runner/widgets/notification/section_title.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Color get background => Color(ColorConstraints.splashBackground_0);
  Color get cardColor => Color(ColorConstraints.backGroundColor);
  Color get accent => Color(ColorConstraints.buttonColor);
  Color get primaryText => Color(ColorConstraints.headLineFontColor);
  Color get secondaryText => Color(ColorConstraints.bodyFontColor);
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: accent,
            size: 20,
          ),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: accent,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Clear all',
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                SectionTitle(
                  title: 'All',
                  color: primaryText,
                ),
                InkWell(
                  onTap: () {

                  },
                  child: SectionTitle(
                    title: 'Check All Read',
                    color: primaryText,
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: _firebaseFirestore.collection(FirebaseConstants.collectionName)
                    .doc("user_gmail").collection(FirebaseConstants.notificationCollection).snapshots(),
                builder: (context, snapshot) {

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if(snapshot.hasError){
                    return Center(
                      child: Text("Error!!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Color(ColorConstraints.bodyFontColor)
                      ),),
                    );
                  }

                  if(snapshot.hasData && snapshot.data == null){
                    return Center(
                      child: Text("No Notifications!!", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Color(ColorConstraints.bodyFontColor)
                      ),),
                    );
                  }

                  final data = snapshot.data?.docs;
                  return ListView.builder(
                    itemCount: data?.length,
                    itemBuilder: (context, index) {

                      final notification = data?[index].data();

                      final createdAt = notification!['createdAt'];
                      final formattedDate = DateFormat('dd MMM yyyy').format(createdAt.toDate(),);
                      return NotificationTile(
                        icon: Icons.directions_run_rounded,
                        iconColor: accent,
                        title: notification["title"],
                        message: notification["message"],
                        time: formattedDate,
                        isUnread: notification["isUnread"],
                      );
                    },
                  );

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
