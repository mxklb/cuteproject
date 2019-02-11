#!/bin/bash
# This script publishes artifacts from gitlab-ci to bintray.
# Depending on the package type it pushes to different repos.
# Supported package types are: debian & appimage
# Debain upload example: ./bintray.sh debian

pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null
cd "$scriptPath"

if [ -z "$1" ]; then
  echo "Package type parameter missing!"
  echo " Try: bintray.sh debian|appimage|.."
  exit 0
fi

# Bintray setup
USER="mxklb"
COMPANY="mx-klb"
REPO="cuteproject"
API_KEY="$BINTRAY_API_KEY"

# Upload debian artifacts to bintray
if [ "$1" == "debian" ]; then
  COMPONENTS="main"
  ARCHITECTURES="amd64"

  # Detect ubuntu codename
  UBUNTU_CODENAME=$(cat /etc/os-release | grep UBUNTU_CODENAME)
  OS=$(echo ${UBUNTU_CODENAME##*=})

  DISTRIBUTIONS="$OS"
  DEBIAN_FILE=$(ls ../*.deb)
  DEBIAN_FILE_NAME=$(echo ${DEBIAN_FILE##*/})

  PACKAGE="$REPO-$OS"
  VERSION=$(bash ./version.sh)
  TARGET="pool/c/$REPO-${VERSION}_$OS"
  TARGET_PATH="$TARGET/$DEBIAN_FILE_NAME"

  curl -T $DEBIAN_FILE -u${USER}:${API_KEY} "https://api.bintray.com/content/$COMPANY/$REPO/$PACKAGE/$VERSION/$TARGET_PATH;deb_distribution=$DISTRIBUTIONS;deb_component=$COMPONENTS;deb_architecture=$ARCHITECTURES;publish=1"
# Upload appimage artifacts to bintray
elif [ "$1" == "appimage" ]; then
  echo "Actually .AppImage upload is not supported!"
  # Upload appImage artifacts to bintray
  #curl -T $APPIMAGE_FILE -u${USER}:${API_KEY} "https://api.bintray.com/content/$COMPANY/cuteproject/<YOUR_COOL_PACKAGE_NAME>/<VERSION_NAME>/<FILE_TARGET_PATH>"

  #Debain package upload:
  #curl -T <FILE.deb> -umxklb:<API_KEY> https://api.bintray.com/content/mx-klb/cuteproject/cuteproject-trusty/<VERSION_NAME>/<FILE_TARGET_PATH>;deb_distribution=<DISTRIBUTIONS>;deb_component=<COMPONENTS>;deb_architecture=<ARCHITECTURES>
  #curl -T <FILE.deb> -umxklb:<API_KEY> https://api.bintray.com/content/mx-klb/cuteproject/<YOUR_COOL_PACKAGE_NAME>/<VERSION_NAME>/<FILE_TARGET_PATH>;deb_distribution=<DISTRIBUTIONS>;deb_component=<COMPONENTS>;deb_architecture=<ARCHITECTURES>

  #Any file upload:
  #curl -T <FILE.EXT> -umxklb:<API_KEY> https://api.bintray.com/content/mx-klb/cuteproject/<YOUR_COOL_PACKAGE_NAME>/<VERSION_NAME>/<FILE_TARGET_PATH>
else
  echo "Unsupported package type parameter!"
fi
