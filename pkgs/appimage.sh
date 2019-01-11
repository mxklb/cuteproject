#!/bin/bash
pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null
cd "$scriptPath"

version="1.0"

# Prepare some files for appimage creation
cp appimage/cuteproject.desktop appimage/app.desktop
sed -i '2s/.*/Version='$version'/' appimage/app.desktop

# Move some files into the app workspace
mv appimage/app.desktop ../app/cuteproject.desktop
cp ../img/cuteproject.png ../app/cuteproject.png

# Clear out qmake artifacts in workspace
find ../ \( -name "moc_*" -or -name "*.o" -or -name "qrc_*" -or -name "ui_*" -or -name "Makefile*" -or -name "*.a" \) -exec rm {} \;

# Download linuxdeployqt-continuous-x86_64.AppImage
wget -c -nv "https://github.com/probonopd/linuxdeployqt/releases/download/continuous/linuxdeployqt-continuous-x86_64.AppImage"
chmod a+x linuxdeployqt-continuous-x86_64.AppImage

# Build the cuteproject-x86_64.AppImage
./linuxdeployqt-continuous-x86_64.AppImage ../app/cuteproject -appimage -bundle-non-qt-libs -verbose=2
