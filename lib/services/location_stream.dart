import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/constraints/color_constraints.dart';

class LocationStream extends ChangeNotifier{
  late Polyline _polyline;
  late LocationSettings locationSettings;
  late LatLng _currentLocation;
  List<LatLng> points = [];
  Polyline get getPolyline => _polyline;
  LatLng get currentLocationStream => _currentLocation;
  StreamSubscription<Position>? positionStream;

  void getCurrentLocationStream() {

    //from package example for location accuracy
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
          //Set foreground notification config to keep the app alive
          //when going to the background
          foregroundNotificationConfig: const ForegroundNotificationConfig(
            notificationText:
            "Runner app will continue to receive your location even when you aren't using it",
            notificationTitle: "Running in Background",
            enableWakeLock: true,
          )
      );
    } else {
      locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }

    // supply location settings to getPositionStream
    points.clear();
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {
          //adding lat lng
          _currentLocation = LatLng(position!.latitude, position.longitude);
          points.add(LatLng(position.latitude, position.longitude));
          _polyline = Polyline(
            polylineId: PolylineId("current_location"),
            visible: true,
            color: Color(ColorConstraints.buttonColor),
            points: points
          );
          notifyListeners();
        });
  }

  //when user will close the app
  //then app will stop location streaming
  void cancelStream(){
    positionStream?.cancel();
    notifyListeners();
  }

}