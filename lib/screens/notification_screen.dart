import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/widgets/notification/notification_tile.dart';
import 'package:runner/widgets/notification/section_title.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  Color get background => Color(ColorConstraints.splashBackground_0);
  Color get cardColor => Color(ColorConstraints.backGroundColor);
  Color get accent => Color(ColorConstraints.buttonColor);
  Color get primaryText => Color(ColorConstraints.headLineFontColor);
  Color get secondaryText => Color(ColorConstraints.bodyFontColor);

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
            color: Color(ColorConstraints.buttonColor),
            size: 20,
          ),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Color(ColorConstraints.buttonColor),
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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionTitle(title: 'All', color: primaryText,),

          NotificationTile(
            icon: Icons.emoji_events_rounded,
            iconColor: accent,
            title: 'New Achievement!',
            message:
            'Congratulations! You completed your 5 km running goal.',
            time: '10:30 AM',
            isUnread: true,
          ),

          NotificationTile(
            icon: Icons.directions_run_rounded,
            iconColor: accent,
            title: 'Run Completed',
            message: 'Great job! You ran 3.5 km in 25 minutes.',
            time: '09:15 AM',
            isUnread: true,
          ),

          NotificationTile(
            icon: Icons.notifications_active_rounded,
            iconColor: Colors.blueAccent,
            title: 'Daily Reminder',
            message:
            'Time to put on your shoes and go for a run!',
            time: '08:00 AM',
            isUnread: false,
          ),
        ],
      ),
    );
  }
}
