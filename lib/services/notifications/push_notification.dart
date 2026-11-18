import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:runner/constraints/firebase_constants.dart';
import 'package:runner/models/notification_model.dart';
import 'package:runner/services/notifications/show_local_notification.dart';

class PushNotification {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      ShowLocalNotification.showLocalNotification(
        title: message.notification?.title ?? "New Notification",
        body: message.notification?.body ?? "You received a new message"
      );
      // storing notification history
      NotificationModel _notification = NotificationModel(
        title: message.notification?.title ?? "New Notification",
        message: message.notification?.body ?? "You received a new message",
        createdAt: DateTime.now()
      );
      await _firebaseFirestore.collection(FirebaseConstants.collectionName).doc("user_gmail")
      .collection(FirebaseConstants.notificationCollection).add({
        "title": _notification.title,
        "message": _notification.message,
        "createdAt": _notification.createdAt,
        "isUnread": _notification.isUnread
      });
    },);
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