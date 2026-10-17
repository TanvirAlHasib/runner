# 🏃 Runner — GPS Running Tracker

**Runner** is a Flutter-based GPS running application designed to help users track outdoor activities, explore running routes, and monitor their running performance through real-time location tracking and Google Maps integration.

The application combines location services, route visualization, and a modern, sports-focused interface to deliver an interactive running experience.

> **Project Status:** Active Development

## Overview

Runner is a mobile fitness application built with **Flutter and Dart**, integrating Google Maps Platform services and device GPS capabilities.

The project focuses on real-time location tracking, route generation, and location-based features while exploring efficient state management and location-stream processing in Flutter.

### Key Highlights

- Google Maps integration
- Real-time GPS location tracking
- Google Places Autocomplete
- Route generation and polyline visualization
- Location permission management
- Multiple running modes
- Provider-based state management
- Modern, dark-themed user interface

## Technology Stack

| Category            | Technology                |
| ------------------- | ------------------------- |
| Framework           | Flutter                   |
| Language            | Dart                      |
| Maps                | Google Maps Flutter       |
| Location Services   | Geolocator                |
| Location Search     | Google Places API         |
| Route Visualization | Flutter Polyline Points   |
| State Management    | Provider / ChangeNotifier |
| Networking          | HTTP / REST APIs          |
| Platform            | Android                   |

## Features

### Google Maps Integration

Runner integrates Google Maps to provide an interactive map interface for location-based running activities.

Features include:

- Interactive Google Maps
- Current location detection
- Map markers
- Route visualization
- Camera positioning and movement
- Location-based navigation interfaces

### Real-Time GPS Tracking

The application uses device location services to monitor GPS updates during running activities.

Implementation includes:

- Continuous location updates using Geolocator
- Location stream management
- GPS accuracy filtering
- Location permission handling
- Position updates through Provider
- Real-time map position updates

The location-tracking system is being refined to improve accuracy and reduce unreliable GPS readings.

### Route Generation

Runner supports route generation using Google Maps services and polyline coordinates.

The route-generation functionality includes:

- Selecting starting and destination locations
- Fetching route coordinates
- Decoding route points
- Drawing polylines on Google Maps
- Visualizing walking routes

### Google Places Autocomplete

Users can search for destinations using Google Places Autocomplete.

The integration supports:

- Location-based search suggestions
- Place selection
- Destination coordinate retrieval
- Route generation based on selected locations

### Running Modes

Runner is designed around three running modes.

**Free Run**

Allows users to track their outdoor running activities without selecting a destination.

**Distance Run**

Enables users to select a destination and visualize a running route.

**Timer Run — Planned**

A time-based running mode designed to let users run for a specified duration.

## Application Architecture

Runner uses Provider and ChangeNotifier to manage application state and location updates.

```text
                    Runner Application
                            |
                            v
                       Flutter UI
                            |
                            v
                    Provider / State
                       Management
                            |
              +-------------+-------------+
              |             |             |
              v             v             v
         Location        Google         Network
         Services         Maps          Services
              |             |             |
              v             v             v
          Geolocator    Maps Flutter    HTTP APIs
              |             |             |
              v             v             v
          GPS Stream    Map Rendering   Places API
              |             |             |
              +-------------+-------------+
                            |
                            v
                    Route Visualization
                            |
                            v
                     Running Interface
```

## Location Tracking

Runner uses `Geolocator.getPositionStream()` to receive continuous location updates.

A dedicated `LocationStream` class extends `ChangeNotifier` to manage location-related state and notify the UI when updates occur.

### Example Location Stream

```dart
if (defaultTargetPlatform == TargetPlatform.android) {
    locationSettings = AndroidSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 2,
    forceLocationManager: true,
    intervalDuration: const Duration(seconds: 2
    foregroundNotificationConfig: const ForegroundNotificationConfig(
    notificationText:
    "Runner app will continue to receive your location even when you aren't using it",
    notificationTitle: "Running in Background",
    enableWakeLock: true,
    ));
} else {
    locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 2,
    );
}

Geolocator.getPositionStream(
  locationSettings: locationSettings,
).listen((Position position) {
  // Process location updates.
  // Update running state.
  // Notify UI listeners.
});
```

### GPS Accuracy Handling

GPS measurements may contain inaccuracies caused by signal interference, device limitations, or environmental conditions.

The application explores techniques such as:

- GPS accuracy validation
- Filtering unreliable location readings
- Reducing unnecessary position updates
- Improving speed measurement reliability

These optimizations are part of ongoing development.

## Route Visualization

Runner uses `flutter_polyline_points` to generate route coordinates and display them on Google Maps.

### Route Generation Flow

```text
User Selects Destination
          |
          v
    Google Places API
          |
          v
   Destination Coordinates
          |
          v
     Route API Request
          |
          v
    Route Point Response
          |
          v
     Polyline Coordinates
          |
          v
    Google Maps Polyline
          |
          v
     Route Visualization
```

## Planned Application Flow

```text
Home Screen
     |
     v
Running Mode Selection
     |
     v
Pre-Run Screen
     |
     v
Live Running Screen
     |
     +-------------------+
     |                   |
     v                   v
Music Controls      Live Tracking
     |                   |
     +-------------------+
               |
               v
        Run Complete
               |
               v
        Run Details
               |
               v
        Running History
               |
               v
        Running Statistics
```

The complete flow is part of the application's development roadmap.

## Getting Started

### Prerequisites

Ensure the following tools are installed:

- Flutter SDK
- Dart SDK
- Android Studio or Visual Studio Code
- Android emulator or physical Android device
- Google Maps Platform API key

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/TanvirAlHasib/runner.git
```

**2. Navigate to the project directory**

```bash
cd runner
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Configure Google Maps**

Create a project in Google Cloud Console and enable the required Google Maps Platform APIs.

Depending on the application's implementation, these may include:

- Maps SDK for Android
- Places API (New)
- Routes API

Configure the API key using the project's Android configuration.

For production applications, restrict API keys appropriately and avoid committing sensitive credentials.

**5. Configure Location Permissions**

Ensure the required Android location permissions are declared in `AndroidManifest.xml`.

```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"
tools:ignore="BackgroundLocationPolicy" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.WAKE_LOCK"/>
```

Additional permissions and foreground-service configuration may be required depending on the Android version and background-tracking functionality.

**6. Run the application**

```bash
flutter run
```

## Development Roadmap

### Maps and Location

- Google Maps integration
- Current location detection
- Google Places Autocomplete
- Route generation
- Polyline visualization
- Location stream implementation
- GPS tracking accuracy improvements
- Reliable running speed calculation

### Running Features

- Complete Free Run mode
- Complete Distance Run mode
- Implement Timer Run mode
- Running session management 
- Running distance calculation 
- Running duration tracking
- Running pace calculation

### User Experience

- Complete running dashboard
- Pre-run configuration
- Live running statistics
- Run completion summary
- Running history
- Performance statistics 
- Music integration
- Profile and settings

## Technical Challenges

### GPS Accuracy

Location services can return inaccurate position and speed measurements, particularly when a device is stationary or GPS signal quality is poor.

Runner explores location accuracy filtering and stream-processing techniques to improve the reliability of running statistics.

### API Integration

Google Maps Platform services require appropriate API configuration, authentication, billing, and quota management.

The application integrates multiple location-based services while considering API usage limits and request efficiency.

### State Management

Continuous GPS updates require efficient state handling to maintain responsive interfaces.

Provider and ChangeNotifier are used to separate location-tracking logic from UI components.

## Project Purpose

Runner is a practical Flutter development project focused on building location-aware mobile applications.

It demonstrates experience with:

- Flutter application development
- Google Maps Platform integration
- GPS and location services
- Asynchronous location streams
- REST API integration
- Provider-based state management
- Runtime permission management
- Interactive map interfaces

## Author

**Tanvir Al-Hasib**

Flutter Developer | Mobile Application Developer

---

**Built with Flutter, Dart, and Google Maps Platform.**
