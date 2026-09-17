import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 13, left: 12, right: 12, bottom: 5),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(
                height: 300,
                child: Stack(
                  alignment: AlignmentGeometry.topLeft,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadiusGeometry.all(Radius.circular(10)),
                      child: GoogleMap(
                        mapType: MapType.hybrid,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(37.42796133580664, -122.085749655962),
                          zoom: 14.4746,
                        ),
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
              const SizedBox(
                height: 18,
              ),
              Text("Run Goals", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Color(ColorConstraints.headLineFontColor),
                  fontWeight: FontWeight.w700
              ),),
              const SizedBox(
                height: 18,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  children: [
                    runGoals("lib/assets/icons/run.svg", "Free Run", context),
                    runGoals("lib/assets/icons/route.svg", "Distance", context),
                    runGoals("lib/assets/icons/timer.svg", "Free Run", context),
                  ],
                ),
              ),
            ],
          ),
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

  // run goals
  Widget runGoals(String iconLocation, String title, BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 5,
        children: [
          SvgPicture.asset(
            iconLocation,
            height: 30,
            colorFilter: ColorFilter.mode(Colors.grey.shade400, BlendMode.srcIn),
          ),
          Text(title, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Color(ColorConstraints.headLineFontColor),
              fontWeight: FontWeight.w800
          ),)
        ],
      ),
    );
  }
}
