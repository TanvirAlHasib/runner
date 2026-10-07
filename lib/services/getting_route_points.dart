import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runner/constraints/credentials.dart';

class GettingRoutePoints {
  static List<LatLng> routePoints = [];
  static PolylinePoints polylinePoints = PolylinePoints(apiKey: Credentials.apiKey);

  static Future<List<LatLng>> getRoutePoints({required LatLng from, required LatLng to}) async{

    final result = await polylinePoints.getRouteBetweenCoordinatesV2(
      request: RoutesApiRequest(
        origin: PointLatLng(from.latitude, from.longitude),
        destination: PointLatLng(to.latitude, to.longitude),
        travelMode: TravelMode.walking,
        routingPreference: RoutingPreference.unspecified // it is needed for walking mode
      )
    );

    routePoints.clear();
    if(result.routes.first.polylinePoints!.isEmpty){
      return routePoints;
    }

    for(final point in polylinePoints.convertToLegacyResult(result).points){
      routePoints.add(LatLng(point.latitude, point.longitude));
    }

    return routePoints;

  }
}