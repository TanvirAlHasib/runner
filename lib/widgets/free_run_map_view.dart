import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:runner/constraints/color_constraints.dart';
import 'package:runner/provider/location_stream.dart';
import 'package:runner/widgets/running_dashboard.dart';

class FreeRunMapView extends StatefulWidget {
  const FreeRunMapView({
    super.key,
    required this.onMapCreated,
    required this.onRecenter,
  });

  final ValueChanged<GoogleMapController> onMapCreated;
  final VoidCallback onRecenter;

  @override
  State<FreeRunMapView> createState() => _FreeRunMapViewState();
}

class _FreeRunMapViewState extends State<FreeRunMapView> {
  static const LatLng defaultLocation = LatLng(23.8103, 90.4125);

  GoogleMapController? _mapController;
  LocationStream? _locationProvider;

  // Stores the user's first GPS position.
  LatLng? _initialMarkerPosition;

  @override
  void initState() {
    super.initState();

    _locationProvider = context.read<LocationStream>();
    _locationProvider!.addListener(_onLocationChanged);

    // Capture the initial location if it is already available.
    _initialMarkerPosition =
        _locationProvider!.currentLocationStream;
  }

  // Camera follows the latest GPS position.
  void _onLocationChanged() {
    final userLocation = _locationProvider?.currentLocationStream;

    if (userLocation == null) return;

    // Set marker position only once.
    _initialMarkerPosition ??= userLocation;

    if (_mapController == null) {
      if (mounted) setState(() {});
      return;
    }

    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: userLocation,
          zoom: 18,
        ),
      ),
    );

    if (mounted) setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    // Notify the parent MapScreen.
    widget.onMapCreated(controller);

    // Move camera to the latest location.
    _onLocationChanged();
  }

  // Manually recenter the camera.
  void _recenterMap() {
    _onLocationChanged();
    widget.onRecenter();
  }

  @override
  void dispose() {
    _locationProvider?.removeListener(_onLocationChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<LocationStream>(
        builder: (context, provider, child) {
          final userLocation = provider.currentLocationStream;
          final polyline = provider.getPolyline;

          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GoogleMap(
                mapType: MapType.hybrid,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                compassEnabled: true,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: userLocation ?? defaultLocation,
                  zoom: userLocation != null ? 18 : 12,
                ),

                // Marker remains at the initial GPS position.
                markers: {
                  if (_initialMarkerPosition != null)
                    Marker(
                      markerId: const MarkerId('initial'),
                      position: _initialMarkerPosition!,
                    ),
                },

                // Live route updates.
                polylines: {
                  if (polyline != null) polyline,
                },

                onMapCreated: _onMapCreated,
              ),

              if (userLocation == null)
                const Center(
                  child: CircularProgressIndicator(),
                ),

              RunnigDashboard(
                distance: provider.totalDistance,
                speed: provider.getSpeed,
                duration: provider.totalMinutes,
                pace: provider.getPace,
              ),

              Positioned(
                bottom: 270,
                right: 15,
                child: CircleAvatar(
                  maxRadius: 25,
                  backgroundColor:
                  Color(ColorConstraints.backGroundColor),
                  child: IconButton(
                    onPressed: _recenterMap,
                    icon: Icon(
                      Icons.location_searching,
                      color: Color(ColorConstraints.buttonColor),
                      size: 25,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
