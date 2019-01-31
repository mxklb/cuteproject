#!/bin/bash
pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null
cd "$scriptPath"

appName="cuteproject"

# Get semantic version number
versions=$($scriptPath/version.sh)
IFS='-' read -a semver <<< "$versions"
version="${semver[0]}"

# Set environment (used by linuxdeployqt)
export VERSION="$versions"

# Prepare some files for appimage creation
cp appimage/$appName.desktop appimage/app.desktop
sed -i 's/M.m/'$version'/g' appimage/app.desktop
sed -i 's/myapp/'$appName'/g' appimage/app.desktop

# Move some files into the app workspace
mv appimage/app.desktop ../app/$appName.desktop
cp ../img/$appName.png ../app/$appName.png

# Clear out qmake artifacts in workspace
find ../ \( -name "moc_*" -or -name "*.o" -or -name "qrc_*" -or -name "ui_*" -or -name "Makefile*" -or -name "*.a" \) -exec rm {} \;

# Download linuxdeployqt-continuous-x86_64.AppImage
wget -c -nv "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
chmod a+x linuxdeployqt-continuous-x86_64.AppImage

# Build the appName-x86_64.AppImage
./linuxdeployqt-continuous-x86_64.AppImage ../app/$appName -appimage -bundle-non-qt-libs -verbose=2
