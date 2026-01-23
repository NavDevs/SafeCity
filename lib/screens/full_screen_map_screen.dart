import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class FullScreenMapScreen extends StatefulWidget {
  final Position? currentPosition;

  const FullScreenMapScreen({super.key, this.currentPosition});

  @override
  State<FullScreenMapScreen> createState() => _FullScreenMapScreenState();
}

class _FullScreenMapScreenState extends State<FullScreenMapScreen> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appBarColor = isDarkMode ? Colors.black : Colors.grey[700]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe City - Map View'),
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _getCurrentLocation(),
            icon: const Icon(Icons.my_location),
            tooltip: 'My Location',
          ),
        ],
      ),
      body: widget.currentPosition != null
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.currentPosition!.latitude,
                  widget.currentPosition!.longitude,
                ),
                zoom: 15.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
              markers: {
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: LatLng(
                    widget.currentPosition!.latitude,
                    widget.currentPosition!.longitude,
                  ),
                  infoWindow: const InfoWindow(
                    title: 'Your Location',
                    snippet: 'You are here',
                  ),
                ),
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapToolbarEnabled: true,
              compassEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              zoomGesturesEnabled: true,
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Location not available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Please enable location services',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
    );
  }

  void _getCurrentLocation() async {
    if (_mapController != null && widget.currentPosition != null) {
      await _mapController!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              widget.currentPosition!.latitude,
              widget.currentPosition!.longitude,
            ),
            zoom: 17.0,
          ),
        ),
      );
    }
  }
}
