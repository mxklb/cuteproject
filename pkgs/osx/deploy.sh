#!/bin/bash
# Deploys (pushes) osx dmg images to the osx-deploy branch.
#
# Note: To be called directly @ travis-ci!
# - Needs $GH_TOKEN to auth git push
# - And $TRAVIS_COMMIT as commit message

pushd `dirname $0` > /dev/null
scriptPath=`pwd`
popd > /dev/null
cd $scriptPath

mkdir dmg
cp $scriptPath/../../app/cuteproject-*.dmg dmg/cuteproject.dmg
cp $scriptPath/appveyor.yml dmg/.appveyor.yml
cp $scriptPath/travis.yml dmg/.travis.yml
cp $scriptPath/README.md dmg/README.md
cd dmg

git init
git config user.name "travis"
git config user.email "travis@email.com"
git add .
git commit -m "OSX deployment - Pushed @ travis-ci [triggered by $TRAVIS_COMMIT]"
git push --force --quiet "https://${GH_TOKEN}@github.com/mxklb/cuteproject" master:osx-deploy > /dev/null 2>&1
