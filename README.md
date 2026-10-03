# Flutter Google Maps & Geolocation Assignment

A feature-rich Flutter application demonstrating Google Maps integration, live GPS tracking via `geolocator`, and interactive markers for favorite locations with detailed bottom sheets.

---

## Features

- **Google Maps Integration**: Displays an interactive map centered on predefined locations with custom markers.
- **Geolocation Services**: Fetches and displays the user's real-time current location using updated permissions and high accuracy.
- **Favorite Locations**: Preloaded list of favorite spots with custom InfoWindows and a dedicated list view to navigate quickly.
- **Interactive Bottom Sheets**: Tapping on map markers or list items opens detailed information about specific coordinates and location names.
- **Modern & Modular Architecture**: Clean project structure separating models, services, screens, and reusable widgets.

---

## Project Structure

```text
lib/
├── models/
│   └── location_model.dart
├── services/
│   └── location_service.dart
├── screens/
│   └── map_screen.dart
├── widgets/
│   └── location_details_sheet.dart
└── main.dart
Prerequisites & Dependencies
​Ensure your project uses the following modern and non-deprecated packages in your pubspec.yaml:
dependencies:
  flutter:
    sdk: flutter
  google_maps_flutter: ^2.5.3
  geolocator: ^11.0.0
Setup & Configuration
​1. Android Configuration
​Permissions & API Key: Add the required permissions and your Google Maps API Key inside android/app/src/main/AndroidManifest.xml:
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<application ...>
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_GOOGLE_MAPS_API_KEY_HERE"/>
</application>
Minimum SDK Version: Ensure minSdk is set to at least 21 in android/app/build.gradle:
defaultConfig {
    minSdk 21
    // other configurations...
}
Running the App
​Clone or download the repository.
​Run flutter pub get to install dependencies.
​Replace YOUR_GOOGLE_MAPS_API_KEY_HERE with your valid Google Maps API Key in AndroidManifest.xml.
​Connect an emulator or physical device and execute:
flutter run
