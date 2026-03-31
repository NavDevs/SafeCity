# Safe City - Your Safety Companion

Safe City is a comprehensive safety application designed to provide users with real-time security features, emergency assistance, and community support. The app leverages GPS technology, mapping services, and community engagement to create a safer environment for users.

## Features

### 📍 Real-Time Location & Mapping
- Interactive map showing user's current location
- Security status indicators (Safe, Caution, High Risk zones)
- Full-screen map view for detailed navigation
- Location sharing during emergencies

### 🚨 Emergency Response System
- **Physical SOS**: Immediate physical danger alerts
- **Cyber SOS**: Digital safety and cyberbullying assistance
- **Emergency Contacts**: Quick access to personal emergency contacts
- Instant notification to contacts, authorities, and community volunteers

### 🔐 User Authentication & Profile Management
- Secure login with personal information
- Profile management with contact details
- Emergency contact setup during registration

### 🛡️ 3-Layer Protection System
- **Surveillance Layer**: Real-time monitoring of safe zones
- **Community Layer**: Volunteer-based safety patrols
- **Technology Layer**: Advanced location tracking and alerts

### 🌍 Indian States Explorer
- Interactive map of Indian states with safety information
- State-wise security details and statistics
- Location-based safety recommendations

### 👥 Community Hub
- Active volunteer network
- Request patrol services in your area
- Real-time community activity feed
- Incident reporting and tracking

### 🏠 Home Dashboard
- Personalized safety score
- Quick access to all safety features
- Account information and settings
- Dark/light mode support

## Technical Stack

- **Framework**: Flutter (Dart)
- **Maps**: Google Maps Flutter
- **State Management**: Provider
- **Location Services**: Geolocator
- **Permissions**: Permission Handler
- **Data Storage**: Shared Preferences
- **UI Components**: Material Design 3

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
```

2. Navigate to the project directory:
```bash
cd SafeCity
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the application:
```bash
flutter run
```

## Download & Deployment

**Note**: This app is currently under development as a college project and is not yet available for public download from official app stores.

### Distribution Methods

The app can be distributed through multiple channels:

- **Google Drive** (Recommended): [Download APK from Google Drive](https://drive.google.com/drive/folders/1Osf8jMaN_GrT0kpfCPdcXufKZ2qOa4-k?usp=sharing) (Access the APK file from our Google Drive folder)


### Local Installation

To install the app on your mobile device:

1. **Development Build**:
   - Connect your mobile device via USB with developer options enabled
   - Run `flutter run` to deploy directly to your device

2. **Release APK**:
   - Generate release APK with `flutter build apk --release`
   - The APK file will be located at `build/app/outputs/flutter-apk/app-release.apk`
   - Transfer and install the APK file to your mobile device

3. **Google Drive Distribution** (Recommended):
   - Upload the APK file to Google Drive
   - Share the direct download link
   - Users can download directly from Google Drive
   - This is the best method for mobile users due to file size limitations

3. **Web Distribution**:
   - Build the APK as described above
   - Place the APK file in the `web/downloads/` directory
   - Deploy the `web/` directory to a static hosting service (GitHub Pages, Netlify, etc.)

4. **App Store Distribution**:
   - For production deployment, build an app bundle with `flutter build appbundle`
   - Upload the app bundle to Google Play Console for distribution

## Permissions Required

- **Location Access**: For real-time location tracking and mapping
- **Phone**: To access emergency contacts
- **Internet**: For map data and emergency notifications

## Screenshots

The application includes various screens:
- Welcome/Login Screen
- Home Dashboard
- Interactive Map View
- Emergency Contacts Management
- State Detail Views
- Account Management

## How to Use

1. **Setup**: Enter your personal information and emergency contacts during initial setup
2. **Monitor**: Check your safety score and location status on the dashboard
3. **Navigate**: Use the interactive map to explore safe zones and state details
4. **Report**: Use SOS buttons when in danger to instantly alert contacts and authorities
5. **Engage**: Participate in the community hub by requesting or offering safety patrols

## Security Features

- Encrypted local storage of user information
- Immediate location sharing during emergencies
- Community-based safety network
- Real-time risk assessment
- Cyber safety awareness resources

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Google Maps Flutter plugin for mapping functionality
- Provider package for state management
- Geolocator for location services
- The community volunteers who make safety possible
