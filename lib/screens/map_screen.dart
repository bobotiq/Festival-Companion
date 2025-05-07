import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  String? _locationError;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _locationError = 'Location services are disabled.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _locationError = 'Location permissions are denied.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _locationError = 'Location permissions are permanently denied.');
        return;
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _locationError = null;
      });

      // Move camera to current position if map is already created
      if (_mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(_currentPosition!),
        );
      }
    } catch (e) {
      setState(() => _locationError = 'Error fetching location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_locationError != null) {
      return Center(child: Text(_locationError!));
    }
    if (_currentPosition == null) {
      return Center(child: CircularProgressIndicator());
    }
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _currentPosition!,
        zoom: 16,
      ),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onMapCreated: (controller) {
        _mapController = controller;
        // Optionally move camera to current position on map creation
        _mapController!.animateCamera(
          CameraUpdate.newLatLng(_currentPosition!),
        );
      },
      markers: {
        Marker(
          markerId: MarkerId('user_location'),
          position: _currentPosition!,
          infoWindow: InfoWindow(title: 'You are here'),
        ),
      },
      // DO NOT turn on liteModeEnabled, as it will disable all gestures
      zoomGesturesEnabled: true,
      scrollGesturesEnabled: true,
      rotateGesturesEnabled: true,
      tiltGesturesEnabled: true,
      compassEnabled: true,
      mapToolbarEnabled: true,
    );
  }
}
