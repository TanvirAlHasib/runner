import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/constraints/credentials.dart';

class GettingRoutePoints {
  static List<LatLng> routePoints = [];
  static PolylinePoints polylinePoints = PolylinePoints(apiKey: Credentials.apiKey);

  static Future<List<LatLng>> getRoutePoints({required LatLng from, required LatLng to}) async{

    final result = await polylinePoints.getRouteBetweenCoordinates(
      request: PolylineRequest(
        origin: PointLatLng(from.latitude, from.longitude),
        destination: PointLatLng(to.latitude, to.longitude),
        mode: TravelMode.walking
      )
    );

    routePoints.clear();
    if(result.points.isEmpty){
      return routePoints;
    }

    for(final point in result.points){
      routePoints.add(LatLng(point.latitude, point.longitude));
    }
    //debug print
    print("route points : $routePoints");
    return routePoints;

  }
}