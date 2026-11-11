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
  int _totalTime = 0;
  DateTime _initialTime = DateTime.now();
  int get totalMinutes => _totalTime;
  double _pace = 0;
  double get getPace => _pace;
  double _speed = 0;
  double get getSpeed => _speed;
  LatLng? previousLatLng;


  Future<void> getCurrentLocationStream() async {
    // Cancel any previous stream.
    await positionStream?.cancel();

    // Reset running data.
    points.clear();
    _totalDistance = 0;
    _totalTime = 0;
    _speed = 0;
    _pace = 0;
    _polyline = null;
    previousLatLng = null;
    _initialTime = DateTime.now();

    // Android location settings.
    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2,
        intervalDuration: const Duration(seconds: 2),
        foregroundNotificationConfig:
        const ForegroundNotificationConfig(
          notificationText:
          "Runner app will continue to receive your location even when you aren't using it",
          notificationTitle: "Running in Background",
          enableWakeLock: true,
        ),
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2,
      );
    }

    // Check location permission.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return;
    }

    // Get cached location first.
    final lastKnownPosition = await Geolocator.getLastKnownPosition();

    if (lastKnownPosition != null) {
      _currentLocation = LatLng(
        lastKnownPosition.latitude,
        lastKnownPosition.longitude,
      );

      points.add(_currentLocation!);

      _polyline = Polyline(
        polylineId: const PolylineId("current_location"),
        color: Color(ColorConstraints.buttonColor),
        width: 5,
        points: List.from(points),
      );

      // Update UI immediately.
      notifyListeners();
    }

    // Start receiving fresh GPS updates.
    positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      // Ignore inaccurate GPS positions.
      if (position.accuracy > 20) return;

      final currentPosition = LatLng(
        position.latitude,
        position.longitude,
      );

      _currentLocation = currentPosition;

      points.add(currentPosition);

      // Calculate distance only after the first fresh GPS position.
      if (previousLatLng != null) {
        final distanceInMeter = Geolocator.distanceBetween(
          previousLatLng!.latitude,
          previousLatLng!.longitude,
          currentPosition.latitude,
          currentPosition.longitude,
        );

        _totalDistance += distanceInMeter / 1000;
      }

      previousLatLng = currentPosition;

      // Calculate speed in km/h.
      final speedInKmh = position.speed * 3.6;

      _speed = speedInKmh < 1 ? 0 : speedInKmh;

      // Calculate elapsed time.
      _totalTime = position.timestamp
          .difference(_initialTime)
          .inMinutes;

      // Calculate pace.
      if (_totalDistance > 0) {
        _pace = _totalTime / _totalDistance;
      }

      // Update polyline.
      _polyline = Polyline(
        polylineId: const PolylineId("current_location"),
        visible: true,
        color: Color(ColorConstraints.buttonColor),
        width: 5,
        points: List.from(points),
      );

      notifyListeners();
    });
  }


  //when user will close the app
  //then app will stop location streaming
  Future<void> cancelStream() async {
    await positionStream?.cancel();
    positionStream = null;
    _initialTime = DateTime.now();
    _speed = 0;
    _pace = 0;
    _totalDistance = 0;
    _totalTime = 0;
    points.clear();
    previousLatLng = null;
    _polyline = null;
    _currentLocation = null;
    notifyListeners();
  }

}