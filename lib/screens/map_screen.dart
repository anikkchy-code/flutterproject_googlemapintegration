import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../models/location_model.dart';
import '../services/location_service.dart';
import '../widgets/location_details_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final LocationService _locationService = LocationService();

  static const CameraPosition _initialPosition = Camera```dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../models/location_model.dart';
import '../services/location_service.dart';
import '../widgets/location_details_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final LocationService _locationService = LocationService();

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(22.8101, 89.5698),
    zoom: 14.0,
  );

  final Set<Marker> _markers = {};

  final List<LocationModel> _favoriteLocations = [
    LocationModel(id: 1, name: 'Khulna University', latitude: 22.8101, longitude: 89.5698),
    LocationModel(id: 2, name: 'Khulna Railway Station', latitude: 22.8151, longitude: 89.5684),
    LocationModel(id: 3, name: 'Shibbari More', latitude: 22.8200, longitude: 89.5500),
  ];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    for (var location in _favoriteLocations) {
      _markers.add(
        Marker(
          markerId: MarkerId(location.id.toString()),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(title: location.name),
          onTap: () {
            _showLocationDetails(location);
          },
        ),
      );
    }
  }

  void _showLocationDetails(LocationModel location) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LocationDetailsSheet(location: location);
      },
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await _locationService.getCurrentLocation();
      LatLng currentLatLng = LatLng(position.latitude, position.longitude);

      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLatLng, zoom: 15.0),
        ),
      );

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: currentLatLng,
            infoWindow: const InfoWindow(title: 'My Current Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _showFavoriteList() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: _favoriteLocations.length,
            itemBuilder: (context, index) {
              final location = _favoriteLocations[index];
              return ListTile(
                leading: const Icon(Icons.location_on, color: Colors.red),
                title: Text(location.name),
                onTap: () {
                  Navigator.pop(context);
                  _mapController.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(location.latitude, location.longitude),
                        zoom: 16.0,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Assignment'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: _showFavoriteList,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        zoomControlsEnabled: true,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
