# Safe City App Distribution Website

This is a static website for distributing the Safe City Android app. The site provides a user-friendly interface for downloading the APK file.

## Structure

- `index.html` - Main landing page with download button and app information
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

## Deployment Options

### GitHub Pages
1. Create a `gh-pages` branch in your repository
2. Copy the contents of the `web/` directory to the root of the branch
3. Enable GitHub Pages in repository settings

### Netlify
1. Upload the `web/` directory contents to Netlify
2. Or connect your GitHub repository and set the publish directory to `web/`

### Manual Deployment
Upload the entire `web/` directory contents to any web server's public directory.

## Customization

Feel free to customize the website design by modifying the CSS in `index.html`. Update the app information, colors, and styling to match your preferences.

## Note

This website is intended for educational/demonstration purposes as part of a college project. Remember to update the copyright year and any other relevant information for your specific use case.