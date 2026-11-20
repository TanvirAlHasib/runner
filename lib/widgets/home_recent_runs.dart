import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../constraints/color_constraints.dart';

class HomeRecentRuns extends StatelessWidget {
  const new({
    super.key,
    required this.totalRun,
    required this.data,
  });

  final int? totalRun;
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: totalRun,
      itemBuilder: (context, index) {
        final runs = data![index].data();
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Color(ColorConstraints.backGroundColor),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                children: [
                  Lottie.asset("lib/assets/animations/walking_avocado.json", height: 100),
                  Expanded(
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(runs["title"], style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Color(ColorConstraints.headLineFontColor),
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                          ),),
                          Text(DateFormat('dd MMM').format(runs["dateTime"].toDate()), style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Color(ColorConstraints.bodyFontColor),
                              fontWeight: FontWeight.w600
                          ),),

                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Text("Distance", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Color(ColorConstraints.bodyFontColor),
                                  fontWeight: FontWeight.w800
                              ),),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(runs["distance"].toStringAsFixed(2), style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Color(ColorConstraints.headLineFontColor),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19
                              ),)
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 7,
                              ),
                              Text("Pace", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Color(ColorConstraints.bodyFontColor),
                                  fontWeight: FontWeight.w800
                              ),),
                              const SizedBox(
                                height: 2,
                              ),
                              Text("${runs["pace"].toStringAsFixed(2)} /KM", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Color(ColorConstraints.headLineFontColor),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19
                              ),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            )
          ]
        );
      },);
  }
}