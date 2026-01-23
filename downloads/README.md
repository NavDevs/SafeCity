# Safe City APK Downloads

This directory contains the APK files for the Safe City Android app.

## Current Status
The main APK file (`safecity-app.apk`) is not yet available in this repository because it needs to be built from the source code.

## How to Build the APK

To generate the APK file, follow these steps:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/nas23ise-dot/SafeCity.git
   cd SafeCity
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Build the release APK:**
   ```bash
   flutter build apk --release
   ```

4. **Copy the APK to the downloads folder:**
   ```bash
   cp build/app/outputs/flutter-apk/app-release.apk downloads/safecity-app.apk
   ```

5. **The APK will then be available at:**
   - https://nas23ise-dot.github.io/SafeCity/downloads/safecity-app.apk

## Alternative Installation Methods

### Direct from Source
- Clone the repository
- Run `flutter run` to install directly to a connected device

### From GitHub Actions (Future)
- When CI/CD is set up, APKs will be automatically built and available here