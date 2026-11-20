import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../constraints/color_constraints.dart';

class Chart extends StatelessWidget {
  new({
    super.key,
    required this.snapshot
  });

  final List<QueryDocumentSnapshot> snapshot;

  Map<int, double> calculateWeeklyDistance(List<QueryDocumentSnapshot> docs) {
    final Map<int, double> dailyDistances = {};
    for (var doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      DateTime date = (data['dateTime'] as Timestamp).toDate();
      // Saturday = 0, Sunday = 1, ... Friday = 6
      int dayIndex = (date.weekday + 1) % 7;
      double distance = (data['distance'] as num).toDouble();
      dailyDistances[dayIndex] = (((dailyDistances[dayIndex] ?? 0) + distance)/100) * 100;
    }
    return dailyDistances;
  }

  Map<int, double> get getCalculatedWeeklyDistance => calculateWeeklyDistance(snapshot);
  late final dailyDistances = getCalculatedWeeklyDistance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: LineChart(
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
        LineChartData(
          maxX: 6,
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
                maxIncluded: true,
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  final days = [
                    'Sat', 'Sun', 'Mon',
                    'Tue', 'Wed', 'Thu', 'Fri',
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
                reservedSize: 35,
                showTitles: true,
                interval: 20,
                getTitlesWidget: (value, meta) {
                  return Text(value.toInt().toString(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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

          backgroundColor: Color(ColorConstraints.splashBackground_0),

          // here will be the data of graph
          lineBarsData: [
            LineChartBarData(
              isCurved: false,
              show: true,
              spots: [
                FlSpot(0, dailyDistances[0] ?? 0),
                FlSpot(1, dailyDistances[1] ?? 0),
                FlSpot(2, dailyDistances[2] ?? 0),
                FlSpot(3, dailyDistances[3] ?? 0),
                FlSpot(4, dailyDistances[4] ?? 0),
                FlSpot(5, dailyDistances[5] ?? 0),
                FlSpot(6, dailyDistances[6] ?? 0),
              ],
              color: Color(ColorConstraints.buttonColor),
              belowBarData: BarAreaData(
                show: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}