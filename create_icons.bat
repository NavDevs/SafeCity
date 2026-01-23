<<<<<<< HEAD
@echo off
echo Creating properly sized app icons for Guardian Go...
echo.

REM Check if ImageMagick is installed
where convert >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ImageMagick is not installed or not in PATH.
    echo Please install ImageMagick from https://imagemagick.org/
    echo Or use an online SVG to PNG converter.
    pause
    exit /b 1
)

echo Converting SVG to PNG formats...

REM Create 1024x1024 square icon (recommended for app stores)
convert "assets\icon\app_icon.svg" -background none -size 1024x1024 "assets\icon_square.png"

REM Create foreground icon for adaptive icons (should be centered with padding)
convert "assets\icon\app_icon.svg" -background none -size 864x864 -gravity center -extent 1024x1024 "assets\icon_foreground.png"

echo.
echo Icons created successfully!
echo - icon_square.png (1024x1024) - Main app icon
echo - icon_foreground.png (1024x1024) - Adaptive icon foreground
echo.
echo Now run: flutter pub get
echo Then run: flutter pub run flutter_launcher_icons:main
echo.
=======
@echo off
echo Creating properly sized app icons for Guardian Go...
echo.

REM Check if ImageMagick is installed
where convert >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ImageMagick is not installed or not in PATH.
    echo Please install ImageMagick from https://imagemagick.org/
    echo Or use an online SVG to PNG converter.
    pause
    exit /b 1
)

echo Converting SVG to PNG formats...

REM Create 1024x1024 square icon (recommended for app stores)
convert "assets\icon\app_icon.svg" -background none -size 1024x1024 "assets\icon_square.png"

REM Create foreground icon for adaptive icons (should be centered with padding)
convert "assets\icon\app_icon.svg" -background none -size 864x864 -gravity center -extent 1024x1024 "assets\icon_foreground.png"

echo.
echo Icons created successfully!
echo - icon_square.png (1024x1024) - Main app icon
echo - icon_foreground.png (1024x1024) - Adaptive icon foreground
echo.
echo Now run: flutter pub get
echo Then run: flutter pub run flutter_launcher_icons:main
echo.
>>>>>>> 2949d0b8221f82aa3b925fbb3755f80a4d14d41d
pause