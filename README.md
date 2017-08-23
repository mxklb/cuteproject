# Cute Project

[![Build Status](https://travis-ci.org/mxklb/cuteproject.svg?branch=master)](https://travis-ci.org/mxklb/cuteproject)
[![codecov](https://codecov.io/gh/mxklb/cuteproject/branch/master/graph/badge.svg)](https://codecov.io/gh/mxklb/cuteproject)
[![build status](https://gitlab.com/mxklb/cuteproject/badges/master/build.svg)](https://gitlab.com/mxklb/cuteproject/commits/master)
[![coverage report](https://gitlab.com/mxklb/cuteproject/badges/master/coverage.svg)](https://gitlab.com/mxklb/cuteproject/commits/master)
[![GitHub license](https://img.shields.io/badge/MIT-license-blue.svg)](https://raw.githubusercontent.com/mxklb/cuteproject/master/LICENSE)

A qmake subdirs template for C++ desktop apps based on modules/libs with automated tests, coverage & deployment.

Download latest development version: [cuteproject_amd64.deb](https://gitlab.com/mxklb/cuteproject/builds/artifacts/master/download?job=deploy_debian)

This is an example/template project with automated unit tests integration (using [catch](https://github.com/philsquared/Catch)). Tests are implememted in separated executabels/subdirs which get executed during compilation incrementally. Compilation fails if any test fails. This is the ideal precondition for test driven development. Deployable packages are build on CI servers. Installable package download links are provided.

Note: This code has no functionality other than being an example/template of a C++/Qt project for test driven development.

## Build Dependencies
To succesfully build on Ubuntu (trusty):

    sudo apt-get install qt5-default qt5-qmake catch gdb

To succesfully build on OSX:

    brew update
    brew install qt5
    export PATH=$(brew --prefix)/opt/qt5/bin:$PATH

## Build Instructions

    qmake
    make

## Development
Development takes place on github while code is being mirrored to gitlab/-ci just for fun ;)

Contribution is welcome - therefore checkout [github issues](https://github.com/mxklb/cuteproject/issues).
