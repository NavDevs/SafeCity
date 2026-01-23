import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../constants/assets.dart';
import '../services/maps_service.dart';
import '../providers/user_provider.dart';
import 'account_screen.dart';
import 'full_screen_map_screen.dart';

class GuardianGoHomePage extends StatefulWidget {
  const GuardianGoHomePage({super.key});

  @override
  State<GuardianGoHomePage> createState() => _GuardianGoHomePageState();
}

class _GuardianGoHomePageState extends State<GuardianGoHomePage>
    with WidgetsBindingObserver {
  final MapsService _mapsService = MapsService();
  GoogleMapController? _mapController;
  Position? _currentPosition;
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getCurrentLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // App came to foreground, check location permissions again
      _getCurrentLocation();
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      // First check if location services are enabled
      bool serviceEnabled = await _mapsService.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoadingLocation = false;
        });
        _showLocationServiceDialog();
        return;
      }

      // Check permission status
      LocationPermission permission = await _mapsService
          .checkLocationPermission();
      if (permission == LocationPermission.denied) {
        permission = await _mapsService.requestLocationPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isLoadingLocation = false;
          });
          _showLocationPermissionDialog();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isLoadingLocation = false;
        });
        _showLocationPermissionPermanentlyDeniedDialog();
        return;
      }

      // Get location if all permissions are granted
      final position = await _mapsService.getCurrentLocation();
      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });
    } catch (e) {
      setState(() {
        _isLoadingLocation = false;
      });
      _showLocationErrorDialog(e.toString());
    }
  }

  Future<void> _refreshLocationManually() async {
    setState(() {
      _isLoadingLocation = true;
    });

    await _getCurrentLocation();

    // Show success message for manual refresh
    if (mounted && _currentPosition != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Location updated successfully'),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.green.withValues(alpha: 0.8),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final appBarColor = isDarkMode ? Colors.black : Colors.grey[700]!;
    final buttonColor = isDarkMode ? Colors.black87 : Colors.grey[600]!;

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
            const SizedBox(width: 8),
            const Text('Safe City'),
          ],
        ),
        backgroundColor: appBarColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutDialog();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.backgroundMap),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.4),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Account Section
                _buildAccountSection(),
                const SizedBox(height: 20),

                // Header Section
                _buildHeaderSection(),
                const SizedBox(height: 20),

                // Four Square Buttons
                _buildActionButtons(buttonColor),
                const SizedBox(height: 24),

                // 3-Layer Protection System
                _build3LayerProtectionSystem(),
                const SizedBox(height: 20),

                // Community Hub
                _buildCommunityHub(buttonColor),
                const SizedBox(height: 20),

                // SOS Response Section
                _buildSOSResponseSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAccountSection() {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return GestureDetector(
          onTap: () => _navigateToAccountScreen(),
          child: Card(
            color: Colors.black.withValues(alpha: 0.4),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[800],
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          userProvider.userEmail,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection() {
    return Card(
      color: Colors.black.withValues(alpha: 0.3),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  Assets.appIcon,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Safe City',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Consumer<UserProvider>(
              builder: (context, userProvider, child) {
                return Text(
                  'Welcome, ${userProvider.userName}!',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Today\'s Safety Score: ',
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'SAFE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(Color buttonColor) {
    return Card(
      color: Colors.black.withValues(alpha: 0.2),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildActionButton(
              'SOS\n(Physical)',
              Icons.warning,
              Colors.red[700]!, // Always red
              () => _showSOSDialog('Physical SOS'),
            ),
            _buildActionButton(
              'Cyber SOS',
              Icons.security,
              buttonColor,
              () => _showSOSDialog('Cyber SOS'),
            ),
            _buildActionButton(
              'Safe Zones',
              Icons.location_on,
              buttonColor,
              () => _navigateToSafeZones(),
            ),
            _buildActionButton(
              'Cyber\nAwareness Hub',
              Icons.school,
              buttonColor,
              () => _navigateToCyberHub(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _build3LayerProtectionSystem() {
    return Card(
      color: Colors.black.withValues(alpha: 0.3),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '3-Layer Protection System',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Map Section
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade300,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _isLoadingLocation
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : _currentPosition != null
                        ? GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: LatLng(
                                _currentPosition!.latitude,
                                _currentPosition!.longitude,
                              ),
                              zoom: 15.0,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _mapController = controller;
                              // Map controller is stored for potential future use
                            },
                            markers: {
                              Marker(
                                markerId: const MarkerId('current_location'),
                                position: LatLng(
                                  _currentPosition!.latitude,
                                  _currentPosition!.longitude,
                                ),
                                infoWindow: const InfoWindow(
                                  title: 'Your Location',
                                ),
                              ),
                            },
                            myLocationEnabled: true,
                            myLocationButtonEnabled: false,
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                          )
                        : const Center(
                            child: Text(
                              'Location not available',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                  ),
                ),
                // Expand button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () => _openFullScreenMap(),
                      icon: const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                        size: 20,
                      ),
                      tooltip: 'Expand Map',
                    ),
                  ),
                ),
                // Refresh location button
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () => _refreshLocationManually(),
                      icon: const Icon(
                        Icons.my_location,
                        color: Colors.white,
                        size: 20,
                      ),
                      tooltip: 'Refresh Location',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Legend
            const Text(
              'Security Status:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildLegendItem('Nearby Surveillance', Colors.green),
            const SizedBox(height: 8),
            _buildLegendItem('Caution', Colors.orange),
            const SizedBox(height: 8),
            _buildLegendItem('High Risk', Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildCommunityHub(Color buttonColor) {
    return Card(
      color: Colors.black.withValues(alpha: 0.3),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Community Hub',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '12 Volunteers active nearby',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => _requestPatrol(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Request Patrol',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Activity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Suspicious activity reported near Park Street',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '→ Volunteers dispatched',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• Safety patrol completed in Downtown area',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSOSResponseSection() {
    return Card(
      color: Colors.red.withValues(alpha: 0.2),
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'SOS Response',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () => _triggerEmergencySOS(),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.4),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'SOS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'In emergency? Press for instant help!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSOSDialog(String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(type, style: const TextStyle(color: Colors.white)),
        content: Text(
          '$type has been activated. Help is on the way!',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  void _navigateToSafeZones() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final snackBarColor = isDarkMode ? Colors.black87 : Colors.grey[600]!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Navigating to Safe Zones...'),
        backgroundColor: snackBarColor,
      ),
    );
  }

  void _navigateToCyberHub() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final snackBarColor = isDarkMode ? Colors.black87 : Colors.grey[600]!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Opening Cyber Awareness Hub...'),
        backgroundColor: snackBarColor,
      ),
    );
  }

  void _requestPatrol() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final snackBarColor = isDarkMode ? Colors.black87 : Colors.grey[600]!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Patrol request sent to nearby volunteers!'),
        backgroundColor: snackBarColor,
      ),
    );
  }

  void _navigateToAccountScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AccountScreen()),
    );
  }

  void _openFullScreenMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FullScreenMapScreen(currentPosition: _currentPosition),
      ),
    );
  }

  void _triggerEmergencySOS() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'EMERGENCY SOS',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        content: const Text(
          'Emergency alert sent!\n\n• Location shared with contacts\n• Nearest emergency services notified\n• Community volunteers alerted',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              final userProvider = Provider.of<UserProvider>(
                context,
                listen: false,
              );
              userProvider.logoutUser();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showLocationServiceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Services Disabled',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Location services are turned off. Please enable location services in your device settings to use location features.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _mapsService.openLocationSettings();
              // Re-check location after user returns from settings
              _getCurrentLocation();
            },
            child: const Text(
              'Open Settings',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Permission Required',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'This app needs location permission to show your current location and provide location-based safety features.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              _getCurrentLocation();
            },
            child: const Text('Retry', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  void _showLocationPermissionPermanentlyDeniedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Permission Permanently Denied',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Location permission has been permanently denied. Please enable it manually in the app settings to use location features.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
              // Re-check location after user returns from settings
              _getCurrentLocation();
            },
            child: const Text(
              'Open App Settings',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Location Error',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Failed to get location: $error',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black87,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }
}
