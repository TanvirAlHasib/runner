import 'package:flutter/material.dart';
import '../constraints/color_constraints.dart';

class RunnigDashboard extends StatelessWidget {
  const new({
    super.key,
    this.distance, this.speed, this.duration, this.pace
  });

  final double? distance;
  final double? speed;
  final int? duration;
  final double? pace;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Container(
        padding: const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 5),
        decoration: BoxDecoration(
            color: Color(ColorConstraints.backGroundColor)
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Distance", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(ColorConstraints.bodyFontColor),
                        fontWeight: FontWeight.w800
                    ),),
                    Text.rich(TextSpan(
                        text: distance != null ? distance!.toStringAsFixed(2) : "0",
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
                  ],
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Time", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(ColorConstraints.bodyFontColor),
                        fontWeight: FontWeight.w800
                    ),),
                    Text.rich(TextSpan(
                        text: duration != null ? "$duration" : "0",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Color(ColorConstraints.buttonColor),
                            fontWeight: FontWeight.w700
                        ),
                        children: [
                          WidgetSpan(child: const SizedBox(
                            width: 5,
                          )),
                          TextSpan(
                              text: "Min",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  color: Color(ColorConstraints.buttonColor),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23
                              )
                          )
                        ]
                    )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Pace", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(ColorConstraints.bodyFontColor),
                        fontWeight: FontWeight.w800
                    ),),
                    Text.rich(TextSpan(
                        text: pace != null ? pace!.toStringAsFixed(2) : "0",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Color(ColorConstraints.buttonColor),
                            fontWeight: FontWeight.w700
                        ),
                        children: [
                          WidgetSpan(child: const SizedBox(
                            width: 5,
                          )),
                          TextSpan(
                              text: "Min/KM",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  color: Color(ColorConstraints.buttonColor),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23
                              )
                          )
                        ]
                    )),
                  ],
                ),
                Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text("Speed", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(ColorConstraints.bodyFontColor),
                        fontWeight: FontWeight.w800
                    ),),
                    Text.rich(TextSpan(
                        text: speed != null ? speed!.toStringAsFixed(1) : "0",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Color(ColorConstraints.buttonColor),
                            fontWeight: FontWeight.w700
                        ),
                        children: [
                          WidgetSpan(child: const SizedBox(
                            width: 5,
                          )),
                          TextSpan(
                              text: "KM/H",
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  color: Color(ColorConstraints.buttonColor),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23
                              )
                          )
                        ]
                    )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              spacing: 15,
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          backgroundColor: Colors.transparent,
                          foregroundColor: Color(ColorConstraints.buttonColor),
                          side: BorderSide(
                              color: Color(ColorConstraints.buttonColor),
                              strokeAlign: BorderSide.strokeAlignOutside,
                              width: 2
                          ),
                          textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          )
                      ),
                      child: Text("Finish")
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size.fromHeight(50),
                          backgroundColor: Color(ColorConstraints.buttonColor),
                          foregroundColor: Color(ColorConstraints.buttonFontColor),
                          textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w800
                          )
                      ),
                      child: Text("Pause Run")
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}