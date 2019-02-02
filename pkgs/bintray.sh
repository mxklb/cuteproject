#!/bin/bash
# This script publishes artifacts to bintray

USER="mxklb"
COMPANY="mx-klb"
API_KEY="$BINTRAY_API_KEY"
VERSION="1.0-5"

# Debian specifics
OS="xenial"
REPO="cuteproject"
DISTRIBUTIONS="testing"
COMPONENTS="main"
ARCHITECTURES="amd64"

DEBIAN_FILE_PATH="pkgs/deb"
DEBIAN_FILE_NAME="cuteproject-1.0_5-1_amd64.deb"
DEBIAN_FILE="$DEBIAN_FILE_PATH/$DEBIAN_FILE_NAME"

PACKAGE="$REPO-$OS"
TARGET="pool/c/$REPO-${VERSION}_$OS"
TARGET_PATH="$TARGET/$DEBIAN_FILE_NAME"

# Upload debian artifact to bintray
curl -vT $DEBIAN_FILE -u${USER}:${API_KEY} "https://api.bintray.com/content/$COMPANY/$REPO/$PACKAGE/$VERSION/$TARGET_PATH;deb_distribution=$DISTRIBUTIONS;deb_component=$COMPONENTS;deb_architecture=$ARCHITECTURES;publish=1"

# Upload appImage artifacts to bintray
#curl -T $APPIMAGE_FILE -u$USER:$API_KEY "https://api.bintray.com/content/$COMPANY/cuteproject/<YOUR_COOL_PACKAGE_NAME>/<VERSION_NAME>/<FILE_TARGET_PATH>"


#Debain package upload:
#curl -T <FILE.deb> -umxklb:<API_KEY> https://api.bintray.com/content/mx-klb/cuteproject/cuteproject-trusty/<VERSION_NAME>/<FILE_TARGET_PATH>;deb_distribution=<DISTRIBUTIONS>;deb_component=<COMPONENTS>;deb_architecture=<ARCHITECTURES>
#curl -T <FILE.deb> -umxklb:<API_KEY> https://api.bintray.com/content/mx-klb/cuteproject/<YOUR_COOL_PACKAGE_NAME>/<VERSION_NAME>/<FILE_TARGET_PATH>;deb_distribution=<DISTRIBUTIONS>;deb_component=<COMPONENTS>;deb_architecture=<ARCHITECTURES>

#Any file upload:
#curl -T <FILE.EXT> -umxklb:<API_KEY> https://api.bintray.com/content/mx-klb/cuteproject/<YOUR_COOL_PACKAGE_NAME>/<VERSION_NAME>/<FILE_TARGET_PATH>
