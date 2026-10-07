import 'dart:ffi' hide Size;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/constraints/mode_enum.dart';
import 'package:runner/utils/get_location.dart';
import '../constraints/color_constraints.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, this.fromLatLng, this.toLatLng, required this.mode});
  final LatLng? fromLatLng;
  final LatLng? toLatLng;
  final String mode;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double? userLat;
  double? userLng;

  @override
  void initState() {
    getUserPositions();
    super.initState();
  }

  //getting the user location
  Future<void> getUserPositions() async{
    Position position = await determinePosition();
    setState(() {
      userLat = position.latitude;
      userLng = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    //if the lat and lng is null
    if (userLat == null || userLng == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if(widget.mode.contains(ModeEnum.freeRun)){
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: LatLng(userLat!, userLng!),
                zoom: 18,
              ),
              markers: {
                //person marker
                Marker(
                  markerId: MarkerId("person"),
                  position: LatLng(userLat!, userLng!),
                  icon: BitmapDescriptor.defaultMarker,
                ),
              },
            ),
            // here calling running dashboard
            RunnigDashboard()
          ],
        ),
      );
    } else if(widget.mode.contains(ModeEnum.distanceRun)){
      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: AlignmentGeometry.bottomCenter,
          children: [
            // here will be selected location map
            GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: CameraPosition(
                target: widget.fromLatLng!,
                zoom: 18,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("from"),
                  position: widget.fromLatLng!,
                  icon: BitmapDescriptor.defaultMarker
                ),
                Marker(
                  markerId: MarkerId("to"),
                  position: widget.toLatLng!,
                  icon: BitmapDescriptor.defaultMarker
                ),
              },
            ),
            // here calling running dashboard
            RunnigDashboard()
          ],
        ),
      );
    } else{
      // for timer interface
      return Scaffold();
    }
  }
}

//below running dashboard
class RunnigDashboard extends StatelessWidget {
  const new({
    super.key,
  });

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
                        text: "5.24",
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
                        text: "32:14",
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Color(ColorConstraints.buttonColor),
                            fontWeight: FontWeight.w700
                        ),
                        children: [
                          WidgetSpan(child: const SizedBox(
                            width: 5,
                          )),
                          TextSpan(
                              text: "Sec",
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
                        text: "6.09",
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
                    Text("Speed", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Color(ColorConstraints.bodyFontColor),
                        fontWeight: FontWeight.w800
                    ),),
                    Text.rich(TextSpan(
                        text: "9.7",
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
                      onPressed: () {

                      },
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
