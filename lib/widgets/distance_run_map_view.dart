import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/provider/location_stream.dart';
import 'package:runner/widgets/running_dashboard.dart';

class DistanceRunMapView extends StatelessWidget {
  const DistanceRunMapView({
    super.key,
    required this.initialLocation,
    required this.destination,
    required this.routePoints,
    required this.isLoadingLocation,
    required this.isLoadingRoute,
    required this.onMapCreated,
  });

  final LatLng? initialLocation;
  final LatLng? destination;
  final List<LatLng> routePoints;

  final bool isLoadingLocation;
  final bool isLoadingRoute;

  final ValueChanged<GoogleMapController> onMapCreated;

  @override
  Widget build(BuildContext context) {
    const defaultLocation = LatLng(23.8103, 90.4125);

    return Consumer<LocationStream>(
      builder: (context, provider, child) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            GoogleMap(
              mapType: MapType.hybrid,
              compassEnabled: true,
              zoomControlsEnabled: true,

              initialCameraPosition: CameraPosition(
                target: initialLocation ?? defaultLocation,
                zoom: initialLocation != null ? 18 : 12,
              ),

              myLocationButtonEnabled: false,
              myLocationEnabled: true,

              onMapCreated: onMapCreated,

              markers: {
                if (destination != null)
                  Marker(
                    markerId: const MarkerId('destination'),
                    position: destination!,
                    icon: BitmapDescriptor.defaultMarker,
                  ),
              },

              polylines: {
                if (routePoints.isNotEmpty)
                  Polyline(
                    polylineId: const PolylineId('remaining_route'),
                    color: Color(ColorConstraints.buttonColor),
                    width: 7,
                    visible: true,
                    points: routePoints,
                  ),
              },
            ),

            if (isLoadingLocation || isLoadingRoute)
              const Positioned(
                top: 20,
                child: CircularProgressIndicator(),
              ),

            RunnigDashboard(
              distance: provider.totalDistance,
              speed: provider.getSpeed,
              duration: provider.totalMinutes,
              pace: provider.getPace,
            ),
          ],
        );
      },
    );
  }
}
