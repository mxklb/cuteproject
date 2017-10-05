# Cute Project

A qmake subdirs template for C++ desktop apps based on modules/libs with automated tests, coverage & deployment.

[![Build Status](https://travis-ci.org/mxklb/cuteproject.svg?branch=master)](https://travis-ci.org/mxklb/cuteproject)
[![codecov](https://codecov.io/gh/mxklb/cuteproject/branch/master/graph/badge.svg)](https://codecov.io/gh/mxklb/cuteproject)
[![build status](https://gitlab.com/mxklb/cuteproject/badges/master/build.svg)](https://gitlab.com/mxklb/cuteproject/commits/master)
[![coverage report](https://gitlab.com/mxklb/cuteproject/badges/master/coverage.svg)](https://gitlab.com/mxklb/cuteproject/builds/artifacts/master/download?job=debug_tests)
[![GitHub license](https://img.shields.io/badge/MIT-license-blue.svg)](https://raw.githubusercontent.com/mxklb/cuteproject/master/LICENSE)

Download latest development version here
-  [cuteproject.ubuntu14.04_amd64.deb](https://gitlab.com/mxklb/cuteproject/builds/artifacts/master/download?job=deploy_trusty)
-  [cuteproject.ubuntu16.04_amd64.deb](https://gitlab.com/mxklb/cuteproject/builds/artifacts/master/download?job=deploy_xenial)

It's an example/template project with automated unit tests integration (using [catch](https://github.com/philsquared/Catch)). Tests are implememted in separated executabels/subdirs which get executed during compilation incrementally. Compilation fails if any test fails. This is the ideal precondition for test driven development. Deployable packages/installers are build by CI servers.

Feel free to use this as starting point for your own C++ qmake project.

## Build Dependencies
To succesfully build on debian based OS:

    sudo apt-get install qt5-default qt5-qmake gdb

To succesfully build on macOS:

    brew update
    brew install qt5
    export PATH=$(brew --prefix)/opt/qt5/bin:$PATH

## Build Instructions

    qmake
    make

## Development
Development takes place on [github](https://github.com/mxklb/cuteproject) while the repository is mirrored to [gitlab](https://gitlab.com/mxklb/cuteproject) for deployment ..

Pull requests are welcome - for contribution checkout [issues](https://github.com/mxklb/cuteproject/issues).
