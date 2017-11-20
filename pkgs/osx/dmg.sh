#!/bin/bash
# This creates a modified copy of a read-only .dmg file
#
# Modifications applied
# - add /Applications sym-link
# - add a background image
# - add a volume icon
#
# Note: This script uses hdiutil!
if [ "$#" -eq  "0" ] ; then
    echo "Error: No arguments supplied!"
    echo " -> Set path to dmg file (1st argument): dmg.sh ..path/to/app.dmg"
    exit 1
fi

pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null

# Prepare some vars ..
dmgDir=$(echo "$(cd "$(dirname "$1")"; pwd)")
dmgName=$(echo "$(basename "$1")")
dmgFile=$(echo "$dmgDir/$dmgName")
binName="${dmgName%.*}"
tmpImage="$dmgDir/$binName.sparseimage"
if [ ! -f "$dmgFile" ] ; then
    echo "Error: $dmgFile file not found!"
    exit 1
fi

# Convert existing dmg to an editable temp image
hdiutil convert -ov "$dmgFile" -format UDSP -o "$tmpImage"

# --> Mount temp image to apply modifications
mntDir=$(hdiutil attach "$tmpImage" | awk '{print $NF}' | tail -1)

# 1. Create /Applications link
ln -s /Applications "$mntDir/Applications"

# 2. Add background image
mkdir "$mntDir/.background"
cp "$scriptPath/background.png" "$mntDir/.background/"

# Fix permissions and blessing
chmod -Rf go-w "${mntDir}" &> /dev/null || true
bless --folder "${mntDir}" --openfolder "${mntDir}"

# 3. Add volume icon file
volumeIcon="$scriptPath/../../img/logo.icns"
cp "$volumeIcon" "$mntDir/.VolumeIcon.icns"
SetFile -c icnC "$mntDir/.VolumeIcon.icns"
if ! test -z "$volumeIcon"; then
   # tell the volume that it has a special file attribute
   SetFile -a C "$mntDir"
fi

# <-- Unmount temp image
hdiutil detach $mntDir && sleep 4

# Write the modified read-only image to disk
hdiutil convert -ov "$tmpImage" -format UDZO -imagekey zlib-level=9 -o "$dmgDir/$binName-mod.dmg"

# Remove temp image
rm "$tmpImage"
