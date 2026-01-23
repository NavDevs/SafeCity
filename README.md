# Safe City App Distribution Website

This is a mobile-optimized static website for distributing the Safe City Android app. The site provides a user-friendly interface for downloading and installing the APK file directly on mobile devices.

## Structure

- `index.html` - Main landing page with mobile-optimized download button, app information, and installation instructions
- `downloads/` - Directory where the APK file will be stored

## Setup Instructions

1. After building the APK file using `flutter build apk --release`, copy the generated APK to the `downloads/` directory:
   ```bash
   cp build/app/outputs/flutter-apk/app-release.apk web/downloads/safecity-app.apk
   ```

2. Deploy the `web/` directory to a static hosting service like:
   - GitHub Pages
   - Netlify
   - Vercel
   - AWS S3
   - Any web server

## File Naming Convention

The download link in `index.html` expects the APK file to be named `safecity-app.apk`. If you use a different name, update the href attribute in the download button:

```html
<a href="./downloads/YOUR_APK_FILENAME.apk" class="download-btn">
```

## Mobile Installation Process

The website is optimized for mobile installations:

1. **Direct Download**: Users can tap the download button to initiate APK download
2. **Mobile-Friendly UI**: Optimized touch targets and layout for mobile devices
3. **Installation Guidance**: Clear, step-by-step instructions for enabling unknown sources and installing the APK
4. **QR Code Option**: QR code for easy access on mobile devices

## Deployment Options

### GitHub Pages (Recommended for Mobile Access)
1. Create a `gh-pages` branch in your repository
2. Copy the contents of the `web/` directory to the root of the branch
3. Enable GitHub Pages in repository settings
4. Share the GitHub Pages URL with users to install directly on their mobile devices

### Netlify
1. Upload the `web/` directory contents to Netlify
2. Or connect your GitHub repository and set the publish directory to `web/`

### Manual Deployment
Upload the entire `web/` directory contents to any web server's public directory.

## Mobile Optimization Features

- **Touch-Optimized Interface**: Large buttons and touch targets for easy interaction
- **Mobile-First Design**: Layout optimized for small screens
- **Reduced Data Usage**: Lightweight design for slower mobile connections
- **Clear Instructions**: Simple, step-by-step installation guidance
- **QR Code Integration**: Easy access via QR code scanning
- **Responsive Design**: Works on all mobile device sizes

## Customization

Feel free to customize the website design by modifying the CSS in `index.html`. Update the app information, colors, and styling to match your preferences.

## Note

This website is intended for educational/demonstration purposes as part of a college project. Remember to update the copyright year and any other relevant information for your specific use case.