import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/constraints/firebase_constants.dart';
import 'package:runner/widgets/my_app_bar.dart';
import '../widgets/home_custom_scroll_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      appBar: MyAppBar(),
      body: Container(
        padding: const EdgeInsets.only(top: 13, left: 12, right: 12, bottom: 5),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            StreamBuilder(
              stream: _firebaseFirestore.collection(FirebaseConstants.collectionName)
              .doc(_firebaseAuth.currentUser!.uid).collection(FirebaseConstants.user).snapshots(),
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

                final userData = snapshot.data!.docs.first.data();
                final username = userData['username'] ?? 'Runner';
                return Text("Welcome back, $username", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Color(ColorConstraints.bodyFontColor),
                    fontWeight: FontWeight.w600
                ),);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                stream: _firebaseFirestore.collection(FirebaseConstants.collectionName)
                .doc(_firebaseAuth.currentUser!.uid).collection(FirebaseConstants.history).where(
                  "dateTime",
                  isGreaterThanOrEqualTo: DateTime.now().subtract(const Duration(days: 7)),
                ).orderBy("dateTime", descending: true).snapshots(),
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

                  // getting the data
                  final data = snapshot.data?.docs;
                  // getting total runs of the week
                  final totalRun = data?.length;
                  // getting total time and avg pace
                  double avgPace = 0;
                  double totalTime = 0;
                  double totalDistance = 0;
                  for(final element in data!){
                    final eachData = element.data();
                    avgPace = avgPace + eachData["pace"];
                    totalTime = totalTime + eachData["duration"];
                    totalDistance = totalDistance + eachData["distance"];
                  }
                  avgPace = avgPace / totalRun!;

                  return HomeCustomScrollView(totalDistance: totalDistance, totalRun: totalRun,
                      totalTime: totalTime, avgPace: avgPace, data: data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}