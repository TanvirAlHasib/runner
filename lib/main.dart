import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:runner/screens/location_stream.dart';
import 'package:runner/screens/splash_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LocationStream(),)
    ], child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Runner Application',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Color(0XFFC6FF00)),
      ),
      home: SplashScreen(),
    );
  }
}
