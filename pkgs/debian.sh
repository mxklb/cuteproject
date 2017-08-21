#!/bin/bash
pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null
cd "$scriptPath"

# Get version info from file
version=$(cat deb/app/version)
majver=${version:0:3}

# Create debian folder ($PACKAGE-$VERSION, f.e myapp-4.2-1)
mkdir deb/app-$version
mkdir deb/app-$version/app
mkdir deb/app-$version/libs
mkdir deb/app-$version/img

# Copy plain sources files (qt/qmake .pro project folder)
cp -r ../app/* deb/app-$version/app
cp -r ../libs/* deb/app-$version/libs
cp -r ../img/* deb/app-$version/img
cp ../globals.pri deb/app-$version
cp ../alltests.pri deb/app-$version
cp ../cuteproject.pro deb/app-$version

# Copy other files (some desktop config)
cp deb/app/app.desktop deb/app-$version/cuteproject.desktop

# Go into build directory
cd deb/app-$version

# Configure build without tests
sed -i '1s/.*/catchTests=false/' globals.pri

# Initialize debian configurations
dh_make --createorig --yes --single --email dev@xamblak.de --copyright mit

# Overwrite defaults with custom configs
cp ../app/app.install debian/app-$majver.install
cp ../app/control debian
cp ../app/menu debian
cp ../app/rules debian
cp ../app/dirs debian

# Write source/package version info into the control file
sed -i '2s/.*/Version='$majver'/' cuteproject.desktop
sed -i '1s/.*/Source: app-'$majver'/' debian/control
sed -i '11s/.*/Package: app-'$majver'/' debian/control

# Set proper rights
#chmod -R -x+X *
chmod -x debian/app-$majver.install
chmod -x debian/control
chmod +x debian/rules
chmod -x debian/menu
chmod -x debian/dirs

# Build the package
dpkg-buildpackage -b -rfakeroot -us -uc -tc
