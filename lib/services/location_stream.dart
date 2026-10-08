import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationStream extends ChangeNotifier{
  late Marker _marker;
  late Polyline _polyline;
  late LocationSettings locationSettings;
  List<LatLng> points = [];
  Marker get getMarker => _marker;
  Polyline get getPolyline => _polyline;
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
    positionStream = Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position? position) {

        });
  }

  //when user will close the app
  //then app will stop location streaming
  void cancelStream(){
    positionStream?.cancel();
  }

}