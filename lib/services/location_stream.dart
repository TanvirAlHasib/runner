import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/services/get_location.dart';

class LocationStream extends ChangeNotifier{
  Polyline? _polyline;
  late LocationSettings locationSettings;
  LatLng? _currentLocation;
  List<LatLng> points = [];
  Polyline? get getPolyline => _polyline;
  LatLng? get currentLocationStream => _currentLocation;
  StreamSubscription<Position>? positionStream;
  double _totalDistance = 0;
  double get totalDistance => _totalDistance;
  double _speed = 0;
  double get getSpeed => _speed;
  LatLng? previousLatLng;

  Future<void> getCurrentLocationStream() async {

    //from package example for location accuracy
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 5,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 5),
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
        distanceFilter: 5,
      );
    }

    // supply location settings to getPositionStream
    points.clear();
    _totalDistance = 0;
    _speed = 0;
    final currentPosition = await geolocator.getCurrentPosition(locationSettings: locationSettings);
    previousLatLng = LatLng(currentPosition.latitude, currentPosition.longitude);

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
          // get distance of runner in km
          _totalDistance = (
              _totalDistance + geolocator.distanceBetween(previousLatLng!.latitude, previousLatLng!.longitude, position.latitude, position.longitude)
          ) / 1000;
          previousLatLng = _currentLocation;
          // get speed of the runner in km/h
          _speed = (position.speed) * 3.6;
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