import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/constraints/firebase_constants.dart';
import '../widgets/chart.dart';
import '../widgets/home_recent_runs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      appBar: myAppBar(context),
      body: Container(
        padding: const EdgeInsets.only(top: 13, left: 12, right: 12, bottom: 5),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text("Welcome back, Tanvir Al Hasib", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(ColorConstraints.bodyFontColor),
              fontWeight: FontWeight.w600
            ),),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder(
                stream: _firebaseFirestore.collection(FirebaseConstants.collectionName)
                .doc("user_gmail").collection(FirebaseConstants.history).where(
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

                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                              color: Color(ColorConstraints.backGroundColor),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: .start,
                            children: [
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Text("This week", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Color(ColorConstraints.bodyFontColor),
                                      fontWeight: FontWeight.w800
                                  ),),
                                  Card(
                                    color: Color(ColorConstraints.cardColor),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2.0, bottom: 2, left: 6, right: 6),
                                      child: Row(
                                        mainAxisSize: .min,
                                        spacing: 3,
                                        children: [
                                          Icon(Icons.fiber_manual_record, color: Color(ColorConstraints.buttonColor), size: 16,),
                                          Text("On Track", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                              color: Color(ColorConstraints.bodyFontColor),
                                              fontWeight: FontWeight.w600
                                          ),)
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text.rich(TextSpan(
                                text: totalDistance.toStringAsFixed(2),
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: Color(ColorConstraints.buttonColor),
                                    fontWeight: FontWeight.w700
                                ),
                                children: [
                                  WidgetSpan(child: const SizedBox(
                                    width: 5,
                                  )),
                                  TextSpan(
                                    text: "KM",
                                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                        color: Color(ColorConstraints.buttonColor),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 23
                                    )
                                  )
                                ]
                              )),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment: .spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text("Runs", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Color(ColorConstraints.bodyFontColor),
                                          fontWeight: FontWeight.w800
                                      ),),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(totalRun.toString(), style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Color(ColorConstraints.headLineFontColor),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 21
                                      ),)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("Time", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Color(ColorConstraints.bodyFontColor),
                                          fontWeight: FontWeight.w800
                                      ),),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(totalTime.toString(), style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Color(ColorConstraints.headLineFontColor),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 21
                                      ),)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text("AVG PACE", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: Color(ColorConstraints.bodyFontColor),
                                          fontWeight: FontWeight.w800
                                      ),),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(avgPace.toStringAsFixed(2), style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                          color: Color(ColorConstraints.headLineFontColor),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 21
                                      ),)
                                    ],
                                  ),
                                ],
                              ),

                              // line chart
                              const SizedBox(
                                height: 30,
                              ),
                              Chart(snapshot: data,),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: const SizedBox(
                          height: 17,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Text("Recent Runs", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: Color(ColorConstraints.headLineFontColor),
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                      SliverToBoxAdapter(
                        child: const SizedBox(
                          height: 15,
                        ),
                      ),
                      HomeRecentRuns(totalRun: totalRun, data: data)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // app bar code
  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color(ColorConstraints.splashBackground_0),
      elevation: 3,
      title: Text("Runner", style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        color: Color(ColorConstraints.buttonColor),
        fontWeight: FontWeight.w800
      ),),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () {
            context.pushNamed("notification");
          },
          icon: Icon(Icons.notifications_none, color: Color(ColorConstraints.buttonColor)),
        )
      ],
      actionsPadding: const EdgeInsets.only(right: 8),
    );
  }
}
