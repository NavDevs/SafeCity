import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/states_provider.dart';
import '../services/maps_service.dart';
import '../models/indian_state.dart';
import '../constants/assets.dart';
import 'state_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapsService _mapsService = MapsService();
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Wait for a moment to ensure provider is initialized
      await Future.delayed(const Duration(milliseconds: 500));

      final statesProvider = Provider.of<StatesProvider>(
        context,
        listen: false,
      );
      _markers = _mapsService.createStateMarkers(
        statesProvider.states,
        (state) => _onStateSelected(state),
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error initializing map: $e')));
    }
  }

  void _onStateSelected(IndianState state) {
    final statesProvider = Provider.of<StatesProvider>(context, listen: false);
    statesProvider.selectState(state);

    // Navigate to state detail screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StateDetailScreen(state: state)),
    );

    // Animate camera to the selected state
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        _mapsService.getStateCameraPosition(state),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              Assets.appIcon,
              width: 32,
              height: 32,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            const Text('Safe City'),
          ],
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.backgroundMap),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withValues(alpha: 0.3),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo
                    Image.asset(
                      Assets.appIcon,
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 24),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Loading Safe City...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Indian States Explorer',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : GoogleMap(
              initialCameraPosition: _mapsService.getIndiaCameraPosition(),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final position = await _mapsService.getCurrentLocation();
            _mapController?.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14,
                ),
              ),
            );

            // Show a snackbar with app branding
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Image.asset(
                        Assets.appIcon,
                        width: 24,
                        height: 24,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      const Text('Location found! Welcome to Safe City'),
                    ],
                  ),
                  backgroundColor: Colors.deepOrange,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          } catch (e) {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error getting location: $e')),
              );
            }
          }
        },
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }
}
