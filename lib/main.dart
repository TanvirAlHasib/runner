import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner/routes/app_routes.dart';
import 'package:runner/provider/location_stream.dart';
import 'package:runner/services/notifications/local_notification_helper.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init local notification
  await LocalNotificationHelper.initialization();
  // init firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
