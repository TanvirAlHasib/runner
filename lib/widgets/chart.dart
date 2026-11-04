import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constraints/color_constraints.dart';

class Chart extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: LineChart(
        duration: Duration(milliseconds: 150),
        curve: Curves.linear,
        LineChartData(
          maxX: 7,
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
                    reservedSize: 35,
                    showTitles: true,
                    interval: 10,
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

          backgroundColor: Colors.black,

          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              show: true,
              spots: [
                FlSpot(0, 35),
                FlSpot(1, 20),
                FlSpot(2, 50),
                FlSpot(3, 10),
                FlSpot(4, 20),
                FlSpot(5, 35),
                FlSpot(6, 0),
              ],
              color: Color(ColorConstraints.buttonColor),
              belowBarData: BarAreaData(
                show: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}