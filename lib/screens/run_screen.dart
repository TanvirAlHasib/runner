import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constraints/color_constraints.dart';

class RunScreen extends StatelessWidget {
  RunScreen({super.key});
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: myAppBar(context),
      body: Container(
        padding: const EdgeInsets.only(top: 13, left: 12, right: 12, bottom: 5),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: AlignmentGeometry.topLeft,
                children: [
                  GoogleMap(
                    mapType: MapType.hybrid,
                    zoomControlsEnabled: true,
                    zoomGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(37.42796133580664, -122.085749655962),
                      zoom: 14.4746,
                    ),
                  ),
                  Card(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisSize: .min,
                      spacing: 3,
                      children: [
                        Icon(Icons.fiber_manual_record, color: Color(ColorConstraints.buttonColor), size: 16,),
                        Text("On Track", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600
                        ),)
                      ],
                    ),
                  )
                ],
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
          onPressed: () {},
          icon: Icon(Icons.notifications_none, color: Color(ColorConstraints.buttonColor)),
        )
      ],
      actionsPadding: const EdgeInsets.only(right: 8),
    );
  }
}
