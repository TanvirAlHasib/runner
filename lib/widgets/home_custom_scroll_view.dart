import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constraints/color_constraints.dart';
import 'chart.dart';
import 'home_recent_runs.dart';

class HomeCustomScrollView extends StatelessWidget {
  const new({
    super.key,
    required this.totalDistance,
    required this.totalRun,
    required this.totalTime,
    required this.avgPace,
    required this.data,
  });

  final double totalDistance;
  final int? totalRun;
  final double totalTime;
  final double avgPace;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;

  @override
  Widget build(BuildContext context) {
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
                Chart(snapshot: data!,),
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
  }
}