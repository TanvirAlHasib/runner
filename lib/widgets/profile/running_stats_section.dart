import 'package:flutter/material.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'stat_card.dart';

class RunningStatsSection extends StatelessWidget {
  const RunningStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: const [
            Expanded(
              child: StatCard(
                icon: Icons.route,
                title: "TOTAL DISTANCE",
                value: "0.0",
                unit: "KM",
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.timer_outlined,
                title: "TOTAL TIME",
                value: "0",
                unit: "HRS",
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        Row(
          children: const [
            Expanded(
              child: StatCard(
                icon: Icons.directions_run,
                title: "TOTAL RUNS",
                value: "0",
                unit: "RUNS",
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.speed,
                title: "AVG. PACE",
                value: "--",
                unit: "/KM",
              ),
            ),
          ],
        ),
      ],
    );
  }
}