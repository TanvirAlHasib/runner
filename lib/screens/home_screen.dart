import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:runner/constraints/color_constraints.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            Text("Good morning, Tanvir Al Hasib", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(ColorConstraints.bodyFontColor),
              fontWeight: FontWeight.w600
            ),),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                    text: "24.3",
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
                          Text("3", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                          Text("2h 14m", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                          Text("5:42", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                    height: 15,
                  ),
                  SizedBox(
                    height: 300,
                    width: double.infinity,
                    child: LineChart(

                      LineChartData(
                        maxX: 100,
                        minX: 0,
                        maxY: 100,
                        minY: 0,
                        borderData: FlBorderData(
                          show: false
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitleAlignment: SideTitleAlignment.outside,
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                final days = [
                                  'Sat',
                                  'Sun',
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                ];
                                if (value < 0 || value > 6) {
                                  return const SizedBox();
                                }
                                return Text(
                                  days[value.toInt()],
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Color(ColorConstraints.bodyFontColor),
                                    fontWeight: FontWeight.w800
                                  ),
                                );
                              },
                            )
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text("10", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Color(ColorConstraints.bodyFontColor),
                                    fontWeight: FontWeight.w800
                                ),);
                              },
                            ),
                            sideTitleAlignment: SideTitleAlignment.outside
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false
                            )
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false
                            )
                          )
                        ),

                        backgroundColor: Colors.black,

                        lineBarsData: [
                          LineChartBarData(
                            isCurved: true,
                            show: true,
                            spots: [
                              FlSpot(0, 35),
                              FlSpot(10, 20),
                              FlSpot(25, 50),
                              FlSpot(35, 10),
                              FlSpot(45, 20),
                              FlSpot(60, 35),
                              FlSpot(75, 0),
                            ],
                            color: Color(ColorConstraints.buttonColor),
                            belowBarData: BarAreaData(
                              show: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Text("Recent Runs", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Color(ColorConstraints.headLineFontColor),
              fontWeight: FontWeight.w700
            ),),
            const SizedBox(
              height: 15,
            ),
            Expanded(child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
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
                                  Text("Morning city", style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: Color(ColorConstraints.headLineFontColor),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  Text("Toady", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                                      Text("3", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                                      Text("5.30 /KM", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
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
              },
            )),
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
          onPressed: () {},
          icon: Icon(Icons.notifications_none, color: Color(ColorConstraints.buttonColor)),
        )
      ],
      actionsPadding: const EdgeInsets.only(right: 8),
    );
  }
}
