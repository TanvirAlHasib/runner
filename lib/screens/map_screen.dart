import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:runner/constraints/mode_enum.dart';
import 'package:runner/models/AutoCompleteLocationModel.dart' hide Text;
import 'package:runner/provider/location_stream.dart';
import 'package:runner/services/auto_complete_location_service.dart';
import 'package:runner/services/getLatLngFromPlaceID.dart';
import 'package:runner/services/get_location.dart';
import 'package:runner/services/getting_route_points.dart';
import '../widgets/destination_search_list.dart';
import '../widgets/distance_run_app_bar.dart';
import '../widgets/distance_run_map_view.dart';
import '../widgets/free_run_map_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.mode,
  });

  final String mode;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Location
  double? userLat;
  double? userLng;

  // Distance Run
  LatLng? destination;
  List<LatLng> routePoints = [];

  // Loading states
  bool isLoadingLocation = false;
  bool isLoadingRoute = false;

  // Map controllers
  GoogleMapController? freeRunMapController;
  GoogleMapController? distanceMapController;

  // Location provider
  late LocationStream locationProvider;

  // Search
  bool searchEnabled = false;
  final TextEditingController locationSearch = TextEditingController();

  List<PlacePrediction?> predictions = [];

  Timer? searchDebounce;

  // Free Run
  bool hasCenteredOnLocation = false;

  // Distance Run route updates
  Timer? routeUpdateDebounce;
  LatLng? pendingRouteLocation;
  LatLng? lastRouteOrigin;

  int routeRequestId = 0;

  bool get isFreeRun =>
      widget.mode.contains(ModeEnum.freeRun);

  @override
  void initState() {
    super.initState();

    locationProvider = context.read<LocationStream>();

    if (isFreeRun) {
      locationProvider.addListener(onLocationChanged);
      locationProvider.getCurrentLocationStream();
    } else {
      locationProvider.addListener(onDistanceLocationChanged);
      getUserPositions();
    }
  }

  // FREE RUN LOCATION

  void onLocationChanged() {
    if (!mounted || hasCenteredOnLocation) return;

    centerOnFreeRunLocation();
  }

  void centerOnFreeRunLocation() {
    final location = locationProvider.currentLocationStream;

    if (location == null || freeRunMapController == null) {
      return;
    }

    hasCenteredOnLocation = true;

    freeRunMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 18,
        ),
      ),
    );
  }

  // DISTANCE RUN LOCATION

  Future<void> getUserPositions() async {
    if (mounted) {
      setState(() {
        isLoadingLocation = true;
      });
    }

    try {
      final Position position = await determinePosition();

      if (!mounted) return;

      final location = LatLng(
        position.latitude,
        position.longitude,
      );

      setState(() {
        userLat = position.latitude;
        userLng = position.longitude;
        isLoadingLocation = false;
      });

      // Start continuous GPS tracking.
      await locationProvider.getCurrentLocationStream();

      if (!mounted) return;

      // Use the latest provider location if available.
      final latestLocation =
          locationProvider.currentLocationStream ?? location;

      centerOnDistanceRunLocation(latestLocation);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoadingLocation = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to get location: $e'),
        ),
      );
    }
  }

  // Listen to every GPS update during Distance Run.
  void onDistanceLocationChanged() {
    if (!mounted) return;

    final currentLocation =
        locationProvider.currentLocationStream;

    if (currentLocation == null) return;

    // Always follow the latest GPS position.
    centerOnDistanceRunLocation(currentLocation);

    // Recalculate the remaining route if a destination exists.
    if (destination != null) {
      scheduleRouteUpdate(currentLocation);
    }
  }

  void centerOnDistanceRunLocation(LatLng location) {
    if (distanceMapController == null) return;

    distanceMapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 18,
        ),
      ),
    );
  }

  // LIVE REMAINING ROUTE

  void scheduleRouteUpdate(LatLng currentLocation) {
    pendingRouteLocation = currentLocation;

    routeUpdateDebounce?.cancel();

    routeUpdateDebounce = Timer(
      const Duration(seconds: 1), () {
        if (!mounted || destination == null) return;
        final latestLocation = pendingRouteLocation;
        if (latestLocation == null) return;
        // Avoid unnecessary API requests for tiny movements.
        if (lastRouteOrigin != null) {
          final distanceMoved = Geolocator.distanceBetween(
            lastRouteOrigin!.latitude,
            lastRouteOrigin!.longitude,
            latestLocation.latitude,
            latestLocation.longitude,
          );

          if (distanceMoved < 15) return;
        }

        updateRemainingRoute(latestLocation);
      },
    );
  }

  Future<void> updateRemainingRoute(
      LatLng currentLocation,
      ) async {
    final selectedDestination = destination;

    if (selectedDestination == null) return;

    // Each request gets a unique ID.
    final requestId = ++routeRequestId;

    // Remember the origin of this request.
    lastRouteOrigin = currentLocation;

    try {
      final updatedPoints =
      await GettingRoutePoints.getRoutePoints(
        from: currentLocation,
        to: selectedDestination,
      );

      if (!mounted || updatedPoints.isEmpty) return;

      // Ignore old responses.
      if (requestId != routeRequestId) return;

      setState(() {
        // Replace the old remaining route.
        routePoints = updatedPoints;
      });
    } catch (e) {
      debugPrint('Remaining route update failed: $e');
    }
  }

  // INITIAL ROUTE FETCHING

  Future<void> getRoutePoints(
      LatLng from,
      LatLng to,
      ) async {
    final requestId = ++routeRequestId;

    setState(() {
      isLoadingRoute = true;
    });

    try {
      final points = await GettingRoutePoints.getRoutePoints(
        from: from,
        to: to,
      );

      if (!mounted) return;

      if (requestId != routeRequestId) return;

      if (points.isEmpty) {
        setState(() {
          isLoadingRoute = false;
        });
        return;
      }

      setState(() {
        routePoints = points;
        isLoadingRoute = false;
      });

      lastRouteOrigin = from;
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoadingRoute = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to fetch route: $e'),
        ),
      );
    }
  }

  // DESTINATION SELECTION

  Future<void> selectDestination(
      PlacePrediction prediction,
      ) async {
    final placeId = prediction.placeId;

    if (placeId == null) return;

    try {
      final LatLng? selectedLocation =
      await GetLatLngFromPlaceId.getLatLng(placeId);

      if (!mounted || selectedLocation == null) return;

      // Use the latest GPS location, not the original location.
      final origin = locationProvider.currentLocationStream ??
          (userLat != null && userLng != null
              ? LatLng(userLat!, userLng!)
              : null);

      setState(() {
        destination = selectedLocation;
        predictions.clear();
        searchEnabled = false;
        locationSearch.clear();

        // Remove the previous destination's route.
        routePoints = [];
      });

      routeUpdateDebounce?.cancel();
      lastRouteOrigin = null;

      if (origin != null) {
        await getRoutePoints(
          origin,
          selectedLocation,
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unable to select destination: $e'),
        ),
      );
    }
  }

  // AUTOCOMPLETE SEARCH

  void onSearchChanged(String value) {
    searchDebounce?.cancel();

    if (value.trim().isEmpty) {
      setState(() {
        predictions.clear();
      });
      return;
    }

    searchDebounce = Timer(
      const Duration(milliseconds: 500),
          () async {
        try {
          final Response response =
          await AutoCompleteLocationService.getAddress(value);

          if (!mounted) return;

          if (response.statusCode == 200 ||
              response.statusCode == 201) {
            final responseMap = jsonDecode(response.body);

            final result =
            AutoCompleteLocationModel.fromJson(responseMap);

            setState(() {
              predictions = (result.suggestions ?? [])
                  .map((item) => item.placePrediction)
                  .toList();
            });
          }
        } catch (e) {
          debugPrint('Autocomplete error: $e');
        }
      },
    );
  }

  void toggleSearch() {
    setState(() {
      searchEnabled = !searchEnabled;
      if (!searchEnabled) {
        locationSearch.clear();
        predictions.clear();
        searchDebounce?.cancel();
      }
    });
  }

  // DISPOSE

  @override
  void dispose() {
    searchDebounce?.cancel();
    routeUpdateDebounce?.cancel();
    locationSearch.dispose();
    if (isFreeRun) {
      locationProvider.removeListener(onLocationChanged);
    } else {
      locationProvider.removeListener(onDistanceLocationChanged);
    }
    // Invalidate any outstanding route requests.
    routeRequestId++;
    locationProvider.cancelStream();
    super.dispose();
  }

  // BUILD

  @override
  Widget build(BuildContext context) {
    if (isFreeRun) {
      return FreeRunMapView(
        onMapCreated: (controller) {
          freeRunMapController = controller;
          centerOnFreeRunLocation();
        },
        onRecenter: () {
          hasCenteredOnLocation = false;
          centerOnFreeRunLocation();
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: DistanceRunAppBar(
        searchEnabled: searchEnabled,
        controller: locationSearch,
        onSearchChanged: onSearchChanged,
        onSearchToggle: toggleSearch,
      ),

      body: Stack(
        children: [
          DistanceRunMapView(
            initialLocation:
            locationProvider.currentLocationStream ??
                (userLat != null && userLng != null
                    ? LatLng(userLat!, userLng!)
                    : null),

            destination: destination,
            routePoints: routePoints,
            isLoadingLocation: isLoadingLocation,
            isLoadingRoute: isLoadingRoute,

            onMapCreated: (controller) {
              distanceMapController = controller;

              // Center on the latest location when the map is ready.
              final currentLocation =
                  locationProvider.currentLocationStream;

              if (currentLocation != null) {
                centerOnDistanceRunLocation(currentLocation);
              } else if (userLat != null && userLng != null) {
                centerOnDistanceRunLocation(
                  LatLng(userLat!, userLng!),
                );
              }
            },
          ),

          DestinationSearchList(
            predictions: predictions,
            onDestinationSelected: selectDestination,
          ),
        ],
      ),
    );
  }
}
