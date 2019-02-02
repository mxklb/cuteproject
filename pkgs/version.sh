#!/bin/bash
# This script prints a sematic version number in the form: "X.Y-Z"
# The version number is fetched from the latest git tag!
# Note: This script needs/depends on git.

pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null
cd "$scriptPath"

# Get version from latest git tag (uses '1.2.3' tags)
gitversion=$(git describe --long)
IFS='-' read -a versions <<< "$gitversion"
IFS='.' read -a semver <<< "${versions[0]}"

# Set version if untagged ..
if [ -z "${semver[0]}" ]; then
  version="1.0-0"
else
  version=$(echo "${semver[0]}.${semver[1]}-${semver[2]}")
fi

echo "$version"
