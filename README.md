<div align="center">

<img src="web/safecity-logo.png" width="120" alt="SafeCity Logo"/>

# 🛡️ SafeCity — Your Safety Companion

**A full-stack safety ecosystem packed into one lightweight Android app.**  
Built as a college project prototype for Smart India Hackathon 2025.

[![Live Website](https://img.shields.io/badge/🌐%20Live%20Website-safe--cty.netlify.app-7C3AED?style=for-the-badge)](https://safe-cty.netlify.app)
[![Download APK](https://img.shields.io/badge/⬇️%20Download%20APK-v1.0.0-10B981?style=for-the-badge)](https://github.com/NavDevs/SafeCity/releases/latest/download/SafeCity.apk)
[![GitHub Release](https://img.shields.io/github/v/release/NavDevs/SafeCity?style=for-the-badge&color=7C3AED)](https://github.com/NavDevs/SafeCity/releases/tag/v1.0.0)
[![Flutter](https://img.shields.io/badge/Flutter-3.35.2-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev)

> ⚠️ **Prototype Application** — This is a college project for academic evaluation only. Not available on the Google Play Store or Apple App Store. Not intended for production use.

</div>

---

## 🌐 Live Website

Visit the landing page to learn more and download the APK:

### 👉 [https://safe-cty.netlify.app](https://safe-cty.netlify.app)

---

## ⬇️ Download

| Platform | Link |
|---|---|
| 🤖 Android APK (Direct) | [**Download SafeCity.apk**](https://github.com/NavDevs/SafeCity/releases/latest/download/SafeCity.apk) |
| ☁️ Google Drive | [**Download from Google Drive**](https://drive.google.com/drive/folders/1Osf8jMaN_GrT0kpfCPdcXufKZ2qOa4-k) |
| 📦 GitHub Release | [View Release v1.0.0](https://github.com/NavDevs/SafeCity/releases/tag/v1.0.0) |

**Requirements:** Android 5.0 (API 21) or higher · ~114 MB

**Installation steps:**
1. Download `SafeCity.apk` from the link above
2. On your Android phone, go to **Settings → Security → Install from unknown sources** → Enable
3. Open the downloaded APK and tap **Install**
4. Launch SafeCity and complete setup!

---

## ✨ Features

### 📍 Real-Time Location & Mapping
- Interactive Google Maps showing your exact position with live GPS
- Security zone colour-coding — **Safe** (green) · **Caution** (amber) · **High Risk** (red)
- Full-screen map view with instant location refresh

### 🚨 Emergency SOS System
- **One-tap Physical SOS** — instantly alerts emergency contacts + nearby volunteers
- **Cyber SOS** — digital safety resources and cyberbullying assistance
- Sub-second broadcast to contacts and authorities

### 🛡️ 3-Layer Protection System
| Layer | Description |
|---|---|
| 📷 Surveillance | Real-time safe zone monitoring with colour-coded status |
| 🤝 Community | Volunteer-based safety patrol network |
| ⚡ Technology | Advanced GPS tracking + encrypted on-device storage |

### 👥 Community Hub
- Active volunteer network with real-time availability
- Request safety patrols in your area
- Incident reporting and tracking

### 🌍 Indian States Explorer
- Interactive map of all 28+ Indian states
- State-wise safety statistics and security details

### 🏠 Home Dashboard
- Personalised safety score
- Quick access to all safety features
- Dark / light mode support

---

## 🔒 Permissions Required

| Permission | Purpose |
|---|---|
| 📍 Location | Real-time GPS tracking and safe zone mapping |
| 📞 Phone | Access and alert emergency contacts |
| 🌐 Internet | Map data and emergency broadcasts |

---

## ⚙️ Tech Stack

| Technology | Purpose |
|---|---|
| 🦋 Flutter (Dart) | Cross-platform mobile framework |
| 🗺️ Google Maps Flutter | Interactive map integration |
| 🔄 Provider | State management |
| 📡 Geolocator | GPS & location services |
| 🎨 Material Design 3 | UI components |
| 💾 SharedPreferences | On-device encrypted storage |
| 🌐 HTML / CSS / JS | Landing page (Claymorphism design) |
| 🚀 Netlify | Website hosting |

---

## 🚀 Running Locally

```bash
# 1. Clone the repo
git clone https://github.com/NavDevs/SafeCity.git
cd SafeCity

# 2. Install Flutter dependencies
flutter pub get

# 3. Run on a connected device or emulator
flutter run

# 4. Build a release APK
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

---

## 🌐 Website Development

The landing page lives in the `web/` directory — plain HTML, CSS, and JS with a Claymorphism design system.

```bash
# Serve locally
python -m http.server 5500 --directory web

# Then open http://localhost:5500
```

Auto-deploys to [safe-cty.netlify.app](https://safe-cty.netlify.app) on every push to `main`.

---

## 📁 Project Structure

```
SafeCity/
├── android/                  # Android native files & app icons
├── lib/                      # Flutter Dart source code
│   └── screens/              # App screens (Home, Map, SOS, etc.)
├── web/                      # Landing page (deployed to Netlify)
│   ├── index.html            # Main page
│   ├── style.css             # Claymorphism design system
│   ├── app.js                # Interactivity & animations
│   └── icons/                # App icons
├── .github/workflows/        # CI/CD (GitHub Actions)
├── netlify.toml              # Netlify deployment config
└── README.md
```

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/my-feature`)
3. Commit your changes (`git commit -m 'feat: add my feature'`)
4. Push to the branch (`git push origin feature/my-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 🙏 Acknowledgments

- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter) — mapping functionality
- [Geolocator](https://pub.dev/packages/geolocator) — GPS & location services
- [Provider](https://pub.dev/packages/provider) — state management
- [Nunito & DM Sans](https://fonts.google.com) — typography
- Community volunteers who make safety possible 💜

---

<div align="center">

Made with 💜 by **NavDevs** · College Project · 2024

[🌐 Website](https://safe-cty.netlify.app) · [⬇️ Download APK](https://github.com/NavDevs/SafeCity/releases/latest/download/SafeCity.apk) · [📦 Releases](https://github.com/NavDevs/SafeCity/releases)

</div>