/// MapScreen provides an interactive map of the festival grounds.
/// Features:
/// - Google Maps integration
/// - Current location tracking
/// - TODO: Points of interest (POI) markers
/// - (Not done) Navigation to specific locations
/// - (Not done) Location sharing with friends
library;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  /// Controller for the Google Maps widget
  GoogleMapController? _mapController;

  /// Starting camera position (latitude, longitude)
  final CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(37.42796, -122.08574), // Example coordinates
    zoom: 15.0,
  );

  /// Set of markers for points of interest (TODO)
  final Set<Marker> _markers = {};

  /// User's current location
  Position? _currentPosition;

  /// Loading state for location data
  bool _isLoading = true;

  /// Current map type
  MapType _mapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    _loadMapData();
  }

  /// Initialize map data and get current location
  Future<void> _loadMapData() async {
    setState(() {
      _isLoading = true;
    });

    // Request location permissions
    await _requestLocationPermission();

    // Add festival POI markers
    _addFestivalMarkers();

    // Try to get current user location
    try {
      _currentPosition = await Geolocator.getCurrentPosition();
    } catch (e) {
      // Handle location error
      // ignore: avoid_print
      print("Error getting location: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  /// Request location permission from user
  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    // Check location permission status
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle permanent denial
      return;
    }
  }

  /// Add festival points of interest to map
  void _addFestivalMarkers() {
    // Example festival locations
    _markers.add(
      Marker(
        markerId: const MarkerId('main_stage'),
        position: const LatLng(37.42796, -122.08574),
        infoWindow: const InfoWindow(
          title: 'Main Stage',
          snippet: 'Headliners perform here',
        ),
      ),
    );

    // More markers would be added for real implementation
  }

  /// Go to user's current location on map
  void _goToCurrentLocation() {
    if (_currentPosition != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _currentPosition!.latitude,
              _currentPosition!.longitude,
            ),
            zoom: 18,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Maps widget
          GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            compassEnabled: true,
            mapToolbarEnabled: false,
            // Use the _mapType variable here to apply the toggle
            mapType: _mapType,
            onMapCreated: (controller) {
              setState(() {
                _mapController = controller;
              });
            },
            padding: const EdgeInsets.only(bottom: 120, right: 9),
          ),
          // Loading indicator
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Current location button - Centers the map on user's location
          FloatingActionButton(
            heroTag: "locationButton",
            onPressed: _goToCurrentLocation,
            mini: true,
            tooltip: 'My Location', // Added tooltip for accessibility
            child: const Icon(Icons.my_location),
          ),
          const SizedBox(height: 16),
          // Map type toggle button - Switches between map and satellite view
          FloatingActionButton(
            heroTag: "mapTypeButton",
            onPressed: _toggleMapType,
            mini: true,
            tooltip: 'Change Map Type', // Added tooltip for accessibility
            child: const Icon(Icons.layers),
          ),
        ],
      ),
    );
  }

  /// Toggle between different map types
  void _toggleMapType() {
    if (_mapController == null) return;

    setState(() {
      // Simple toggle between normal and satellite view
      if (_mapType == MapType.normal) {
        _mapType = MapType.satellite;
      } else {
        _mapType = MapType.normal;
      }
    });
  }
}
