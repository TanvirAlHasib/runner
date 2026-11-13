import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:runner/constraints/notification_constants.dart';

class ShowLocalNotification {
  static final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  // show local notification
  Future<void> showLocalNotification({required String title, required String body}) async{
    await notificationsPlugin.show(
      id: 100,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          NotificationConstants.channelID,
          NotificationConstants.channelName,
          importance: Importance.high,
          priority: Priority.high
        )
      )
    );
  }
}