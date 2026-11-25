import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/constraints/firebase_constants.dart';
import 'stat_card.dart';

class RunningStatsSection extends StatelessWidget {
  RunningStatsSection({super.key});
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseFirestore.collection(FirebaseConstants.collectionName).doc(_firebaseAuth.currentUser!.uid)
        .collection(FirebaseConstants.history).snapshots(),
      builder: (context, asyncSnapshot) {

        if(asyncSnapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }

        final data = asyncSnapshot.data?.docs;
        final totalRun = data?.length ?? 0;
        double totalDistance = 0.0;
        double totalTime = 0;
        double avgPace = 0;
        //getting all of this
        if(data != null){
          for(final doc in data){
            final eachData = doc.data();
            totalDistance = totalDistance + eachData["distance"];
            totalTime = totalTime + eachData["duration"];
            avgPace = avgPace + eachData["pace"];
          }
          avgPace = avgPace/totalTime;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "RUNNING OVERVIEW",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Color(ColorConstraints.headLineFontColor),
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.route,
                    title: "TOTAL DISTANCE",
                    value: totalDistance.toStringAsFixed(2),
                    unit: "KM",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.timer_outlined,
                    title: "TOTAL TIME",
                    value: "$totalTime",
                    unit: "Mn",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: StatCard(
                    icon: Icons.directions_run,
                    title: "TOTAL RUNS",
                    value: "$totalRun",
                    unit: "RUNS",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    icon: Icons.speed,
                    title: "AVG. PACE",
                    value: avgPace.toStringAsFixed(2),
                    unit: "/KM",
                  ),
                ),
              ],
            ),
          ],
        );
      }
    );
  }
}