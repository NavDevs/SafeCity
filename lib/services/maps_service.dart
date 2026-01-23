import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/indian_state.dart';

class MapsService {
  // Get user's current location
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can get the location
    return await Geolocator.getCurrentPosition();
  }

  // Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  // Check location permission status
  Future<LocationPermission> checkLocationPermission() async {
    return await Geolocator.checkPermission();
  }

  // Request location permission
  Future<LocationPermission> requestLocationPermission() async {
    return await Geolocator.requestPermission();
  }

  // Open device location settings
  Future<bool> openLocationSettings() async {
    return await Geolocator.openLocationSettings();
  }

  // Open app settings
  Future<bool> openAppSettings() async {
    return await Permission.location.request().isGranted;
  }

  // Create markers for Indian states
  Set<Marker> createStateMarkers(
    List<IndianState> states,
    Function(IndianState) onTap,
  ) {
    return states.map((state) {
      return Marker(
        markerId: MarkerId(state.name),
        position: LatLng(state.latitude, state.longitude),
        infoWindow: InfoWindow(title: state.name, snippet: state.capital),
        onTap: () => onTap(state),
      );
    }).toSet();
  }

  // Get camera position for India
  CameraPosition getIndiaCameraPosition() {
    // Center of India approximately
    return const CameraPosition(target: LatLng(23.5937, 78.9629), zoom: 5);
  }

  // Get camera position for a specific state
  CameraPosition getStateCameraPosition(IndianState state) {
    return CameraPosition(
      target: LatLng(state.latitude, state.longitude),
      zoom: 8,
    );
  }
}
