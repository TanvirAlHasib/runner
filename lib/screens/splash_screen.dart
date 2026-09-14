import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    chooseNextScreen();
    super.initState();
  }

  Future<void> chooseNextScreen() async{
    Future.delayed(Duration(seconds: 3), () {
      if(mounted){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(ColorConstraints.splashBackground_0),
              Color(ColorConstraints.backGroundColor),
              Color(ColorConstraints.splashBackground_1),
              Color(ColorConstraints.backGroundColor),
              Color(ColorConstraints.splashBackground_0),
            ],
            begin: AlignmentGeometry.topRight,
            end: AlignmentGeometry.bottomLeft,
            tileMode: TileMode.mirror
          ),
        ),
        child: Column(
          crossAxisAlignment: .center,
          children: [
            Spacer(),
            Lottie.asset("lib/assets/animations/space_runner.json", height: 300),
            const SizedBox(
              height: 15,
            ),
            Text("Runner", style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: Color(ColorConstraints.buttonColor),
              fontWeight: FontWeight.w800
            ),),
            Spacer(flex: 2,)
          ],
        ),
      ),
    );
  }
}
