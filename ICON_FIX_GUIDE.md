# Guardian Go - App Icon Fix Guide

## Problem
The app icon appears compressed/squished when the APK is built.

## Root Cause
The current icon (`assets/icon.png`) may not be perfectly square (1:1 aspect ratio) or may be too large, causing compression artifacts.

## Solutions

### Option 1: Use ImageMagick (Recommended)
1. Install ImageMagick from https://imagemagick.org/
2. Run the provided `create_icons.bat` script
3. This will create properly sized icons from the SVG

### Option 2: Manual Icon Creation
1. Open the SVG file (`assets/icon/app_icon.svg`) in any vector graphics editor (Inkscape, Adobe Illustrator, etc.)
2. Export as PNG with these specifications:
   - **Size**: 1024x1024 pixels (square)
   - **Format**: PNG with transparency
   - **Name**: `icon_square.png`
   - **Location**: `assets/` folder

3. Create a second version for adaptive icons:
   - **Size**: 1024x1024 pixels
   - **Content**: Same icon but centered with 80px padding on all sides
   - **Name**: `icon_foreground.png`
   - **Location**: `assets/` folder

### Option 3: Online Conversion
1. Use an online SVG to PNG converter
2. Upload `assets/icon/app_icon.svg`
3. Set output size to 1024x1024 pixels
4. Download and save as `assets/icon_square.png`

### Option 4: Use Current Icon (Quick Fix)
If you want to use the existing icon.png, rename it:
```bash
copy assets\icon.png assets\icon_square.png
copy assets\icon.png assets\icon_foreground.png
```

## After Creating Icons

1. Run `flutter pub get`
2. Run `flutter pub run flutter_launcher_icons:main`
3. Build your APK: `flutter build apk`

## Verification
- Check that icons appear square in the app drawer
- Icons should not appear compressed or stretched
- Icon should maintain proper aspect ratio

## Icon Specifications
- **Minimum size**: 512x512 pixels
- **Recommended size**: 1024x1024 pixels
- **Aspect ratio**: 1:1 (perfect square)
- **Format**: PNG with transparency
- **Adaptive icon**: Foreground should have safe zone (avoid content in outer 25% of icon)