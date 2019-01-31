#!/bin/bash
# This script creates a deployable macOS image (application.dmg)
#
# It moves all custom libs (frameworks) to the app bundle and
# corrects local binary linker-paths accordingly. Finally Qt
# and external libs are copied & linked to Frameworks folder.
#
# Note this script dependes on:
# - otool (to detect custom linked local frameworks)
# - install_name_tool (to correct binary links)
# - macdeployqt (to create a dmg image)
pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null
cd "$scriptPath"

# Set essentials
appName="cuteproject"
libIdentifier="cuteproject/libs"

# Set some paths
libPath="$scriptPath/../libs"
appPath="$scriptPath/../app/$appName.app"
binPath="$appPath/Contents/MacOS/$appName"

echo "Fix macdeployqt: Copy all needed qt frameworks .."

# Create Frameworks directory
appFrameworksPath="$appPath/Contents/Frameworks"
mkdir -p $appFrameworksPath

# Detect all linked Qt libs/frameworks
qtLibs=($(otool -L $binPath | grep Qt))
qtLibs=($(printf '%s\n' "${qtLibs[@]}" | grep Qt))
qtLibs=($(echo ${qtLibs[@]##*/}))
qtLibPath=$(qmake --version | grep "Using Qt" | awk -F" " '{print $NF}')

# Copy Qt frameworks
libCount=${#qtLibs[@]}
for ((i=0; i<$libCount; i++)); do
    echo " - Copy $qtLibPath/${qtLibs[$i]} -> $appFrameworksPath .."
    cp -Ra $qtLibPath/${qtLibs[$i]}.framework $appFrameworksPath
done

echo "Setup custom $appName library dependencies ..."

# Use otool to grep libIdentifier => to get all custom linked frameworks
linkedLibs=($(otool -L $binPath | grep $libIdentifier | awk '{print $1;}'))
frameworks=($(printf '%s\n' "${linkedLibs[@]}" | rev | cut -d'/' -f 1 | rev))

# Copy frameworks and correct links
libCount=${#linkedLibs[@]}
for ((i=0; i<$libCount; i++)); do
    echo " - Preparing ${frameworks[$i]} framework: substitute ${linkedLibs[$i]} with @executable_path"
    cp -Ra $libPath/${frameworks[$i]}/${frameworks[$i]}.framework $appPath/Contents/Frameworks
    install_name_tool -id @executable_path/../Frameworks/${frameworks[$i]}.framework/Versions/1/${frameworks[$i]} $appPath/Contents/Frameworks/${frameworks[$i]}.framework/Versions/1/${frameworks[$i]}
    install_name_tool -change ${linkedLibs[$i]} @executable_path/../Frameworks/${frameworks[$i]}.framework/Versions/1/${frameworks[$i]} $binPath
done

libBinaries=()

# Correct all internal frameworks links
for ((i=0; i<$libCount; i++)); do
    libBinPath="$appPath/Contents/Frameworks/${frameworks[$i]}.framework/Versions/1/${frameworks[$i]}"
    dependLibs=($(otool -L $libBinPath | grep $libIdentifier | awk '{print $1;}'))
    dependency=($(printf '%s\n' "${dependLibs[@]}" | rev | cut -d'/' -f 1 | rev))
    echo "Setup ${frameworks[$i]} framework dependencies ..."
    depCount=${#dependLibs[@]}
    for ((j=0; j<$depCount; j++)); do
        echo " - Preparing ${dependency[$j]} framework: substitute ${dependLibs[$j]} with @executable_path"
        install_name_tool -id @executable_path/../Frameworks/${dependency[$j]}.framework/Versions/1/${dependency[$j]} $appPath/Contents/Frameworks/${dependency[$j]}.framework/Versions/1/${dependency[$j]}
        install_name_tool -change ${dependLibs[$j]} @executable_path/../Frameworks/${dependency[$j]}.framework/Versions/1/${dependency[$j]} $libBinPath
    done
    libBinaries+=("-executable=$libBinPath")
done

# Collect binaries for macdeployqt cmd
executables=$(echo "${libBinaries[*]}")

# Create a .dmg image (with Qt libs)
echo "Creating the .dmg disk image ..."
cd "$scriptPath/../app"
macdeployqt "$appName.app" -dmg $executables -verbose=2 -always-overwrite

# Modify/Optimize .dmg image
chmod +x "$scriptPath/osx/dmg.sh"
$scriptPath/osx/dmg.sh "$scriptPath/../app/$appName.dmg"
