import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:runner/services/notifications/show_local_notification.dart';

class PushNotification {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final ValueNotifier<List<RemoteMessage>> foreGroundMessage = ValueNotifier<List<RemoteMessage>>([]);

  // initializing the firebase messaging
  static Future<void> init() async{
    // notification setting
    await _messaging.requestPermission(
      alert: true,
      announcement: true,
      sound: true,
      badge: true
    );

    getMessage();
    getFIDToken();
  }

  // getting the message
  static void getMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      foreGroundMessage.value = [...foreGroundMessage.value, message];
      ShowLocalNotification.showLocalNotification(
        title: message.notification?.title ?? "New Notification",
        body: message.notification?.body ?? "You received a new message"
      );
    },);
    debugPrint("Message: ${foreGroundMessage.value.length}");
  }

  // get the firebase installation id
  // instead FCM because that is deprecated
  static Future<void> getFIDToken() async{
    String? FID;
    _messaging.onRegistered.listen((String id) {
      FID = id;
      debugPrint("FCM: $FID");
    },);

    await _messaging.register();
  }
}