# Cute Project

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/mxklb/cuteproject/master/LICENSE)
[![Build Status](https://travis-ci.org/mxklb/cuteproject.svg?branch=master)](https://travis-ci.org/mxklb/cuteproject)
[![codecov](https://codecov.io/gh/mxklb/cuteproject/branch/master/graph/badge.svg)](https://codecov.io/gh/mxklb/cuteproject)
[![build status](https://gitlab.com/mxklb/cuteproject/badges/master/build.svg)](https://gitlab.com/mxklb/cuteproject/commits/master)
[![coverage report](https://gitlab.com/mxklb/cuteproject/badges/master/coverage.svg)](https://gitlab.com/mxklb/cuteproject/commits/master)

A simple qmake subdirs project for writing C++ desktop apps based on modules/libs with automated CI tests & coverage.

This aims to be a example/template qmake project with automated unit tests integration (using [catch](https://github.com/philsquared/Catch)). Tests are implememted in separated executabels/subdirs which get executed during compilation incrementally .. compilation fails if any test fails ..

This code has no functionality other than being an example/template for a C++/Qt project.

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
