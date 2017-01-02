# Cute Project

[![Build Status](https://travis-ci.org/mxklb/cuteproject.svg?branch=master)](https://travis-ci.org/mxklb/cuteproject)
[![codecov](https://codecov.io/gh/mxklb/cuteproject/branch/master/graph/badge.svg)](https://codecov.io/gh/mxklb/cuteproject)

A simple qmake subdirs project with libs and tests. 

This aims to be a template/example qmake project with automated unit tests integration (using [catch](https://github.com/philsquared/Catch)). Tests are implememted in separated executabels/subdirs which get executed during compilation incrementally .. compilation fails if a test fails ..

## Build Dependencies
To succesfully build on Ubuntu (trusty): 

    sudo apt-get install qt5-default qt5-qmake catch
    
To succesfully build on OSX:
    
    brew update
    brew install qt5
    export PATH=$(brew --prefix)/opt/qt5/bin:$PATH

## Build Instructions

    qmake
    make
