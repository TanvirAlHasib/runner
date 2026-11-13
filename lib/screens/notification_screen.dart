
import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';

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
          _sectionTitle('Today', primaryText),

          _notificationTile(
            icon: Icons.emoji_events_rounded,
            iconColor: accent,
            title: 'New Achievement!',
            message:
            'Congratulations! You completed your 5 km running goal.',
            time: '10:30 AM',
            isUnread: true,
          ),

          _notificationTile(
            icon: Icons.directions_run_rounded,
            iconColor: accent,
            title: 'Run Completed',
            message: 'Great job! You ran 3.5 km in 25 minutes.',
            time: '09:15 AM',
            isUnread: true,
          ),

          const SizedBox(height: 24),

          _sectionTitle('Yesterday', primaryText),

          _notificationTile(
            icon: Icons.notifications_active_rounded,
            iconColor: Colors.blueAccent,
            title: 'Daily Reminder',
            message:
            'Time to put on your shoes and go for a run!',
            time: '08:00 AM',
            isUnread: false,
          ),

          _notificationTile(
            icon: Icons.flag_rounded,
            iconColor: Colors.greenAccent,
            title: 'Goal Achieved',
            message:
            'You reached your weekly running target.',
            time: '06:45 PM',
            isUnread: false,
          ),

          const SizedBox(height: 24),

          _sectionTitle('Earlier', primaryText),

          _notificationTile(
            icon: Icons.favorite_rounded,
            iconColor: Colors.redAccent,
            title: 'Keep Going!',
            message:
            'Consistency is the key. Keep up your progress!',
            time: 'Nov 10',
            isUnread: false,
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _notificationTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isUnread
              ? accent.withValues(alpha: 0.35)
              : Colors.white.withValues(alpha: 0.04),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.13),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 23,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: primaryText,
                        ),
                      ),
                    ),

                    if (isUnread)
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  message,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: secondaryText,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: secondaryText.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
