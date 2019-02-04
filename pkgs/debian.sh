#!/bin/bash
pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null
cd "$scriptPath"

# Set some app infos
appName="cuteproject"
eMail="mxklb@protonmail.com"
ghUser="mxklb"

# Set package maintainer
export LOGNAME=$USER

# Create deb/app/version file
version=$($scriptPath/version.sh)
echo "$version" | tee deb/app/version

majver=${version:0:3}
pkgname="$appName"

# Create debian folder ($PACKAGE-$VERSION, f.e myapp-4.2-1)
mkdir deb/$pkgname-$version
mkdir deb/$pkgname-$version/app
mkdir deb/$pkgname-$version/libs
mkdir deb/$pkgname-$version/img
mkdir deb/$pkgname-$version/.git

# Copy plain sources files (qt/qmake .pro project folder)
cp -r ../app/* deb/$pkgname-$version/app
cp -r ../libs/* deb/$pkgname-$version/libs
cp -r ../img/* deb/$pkgname-$version/img
cp -r ../.git/* deb/$pkgname-$version/.git
cp ../globals.pri deb/$pkgname-$version
cp ../alltests.pri deb/$pkgname-$version
cp ../$appName.pro deb/$pkgname-$version

# Copy other files (some desktop config)
cp deb/app/app.desktop deb/$pkgname-$version/$pkgname.desktop

# Go into build directory
cd deb/$pkgname-$version

# Configure build without tests
echo "catchTests=false" > globals.pri

# Initialize debian configurations
dh_make --createorig --yes --single --email $eMail --copyright mit

# Overwrite defaults with custom configs
cp ../app/app.install debian/$pkgname-$majver.install
cp ../app/control debian
cp ../app/menu debian
cp ../app/rules debian
cp ../app/dirs debian
cp ../app/changelog debian

# Prepare the $pkgname.desktop file
sed -i 's/M.m/'$version'/g' $pkgname.desktop
sed -i 's/myapp/'$pkgname'/g' $pkgname.desktop

# Prepare $pkgname-$majver.install file
sed -i 's/myapp/'$pkgname'/g' debian/$pkgname-$majver.install

# Prepare the debian/control file
ghProject="$appName"
ghUrl="https:\/\/github.com\/$ghUser\/$ghProject"
sed -i '4s/.*/Maintainer: '$ghUser' \<'$eMail'\>/' debian/control
sed -i '7s/.*/Homepage: '$ghUrl'/' debian/control
sed -i '8s/.*/Vcs-Git: '$ghUrl'.git/' debian/control
sed -i '9s/.*/Vcs-Browser: '$ghUrl'/' debian/control
sed -i 's/myapp/'$pkgname'/g' debian/control
sed -i 's/M.m/'$majver'/g' debian/control

# Prepare the debian/menu file
sed -i 's/myapp/'$pkgname'/g' debian/menu
sed -i 's/app-1.0-0/'$pkgname'-'$version'/g' debian/menu

# Prepare the debian/rules file
sed -i 's/myapp/'$pkgname'/g' debian/rules

# Set proper rights
#chmod -R -x+X *
chmod -x debian/$pkgname-$majver.install
chmod -x debian/changelog
chmod -x debian/control
chmod +x debian/rules
chmod -x debian/menu
chmod -x debian/dirs

# Correct debian/copyright template
sed -i '32,37d' debian/copyright
sed -i '4,9d' debian/copyright
sed -i '6d' debian/copyright
sed -i '3s/.*/Source: <https:\/\/github.com\/'$ghUser'\/'$ghProject'>/' debian/copyright

# Append latest commits to changelog
../changelog.sh >> debian/tmplog
cat debian/changelog >> debian/tmplog
cat debian/tmplog > debian/changelog
rm debian/tmplog

# Build the package
dpkg-buildpackage -b -rfakeroot -us -uc -tc
