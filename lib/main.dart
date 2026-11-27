import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:runner/routes/app_routes.dart';
import 'package:runner/provider/location_stream.dart';
import 'package:runner/services/notifications/local_notification_helper.dart';
import 'package:runner/services/notifications/push_notification.dart';
import 'constraints/firebase_constants.dart';
import 'firebase_options.dart';
import 'models/notification_model.dart';

// for push notification when the app is killed
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{

  // it is needed because it will be run when the app is terminated, from background
  // so, I need to check it
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  // storing the notification in same place
  // storing notification history
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  NotificationModel notification = NotificationModel(
      title: message.notification?.title ?? "New Notification",
      message: message.notification?.body ?? "You received a new message",
      createdAt: DateTime.now()
  );
  await firebaseFirestore.collection(FirebaseConstants.collectionName).doc(firebaseAuth.currentUser!.uid)
      .collection(FirebaseConstants.notificationCollection).add({
    "title": notification.title,
    "message": notification.message,
    "createdAt": notification.createdAt,
    "isUnread": notification.isUnread
  });

}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init local notification
  await LocalNotificationHelper.initialization();
  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoogleSignIn.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler,);
  //  for push notification
  await PushNotification.init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LocationStream(),)
    ], child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Runner Application',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color(0XFFC6FF00)),
      ),
      routerConfig: router,
    );
  }
}
