# Cute Project

A simple qmake subdirs project with libs and tests. 

This aims to be a template/example qmake project with automated unit tests integration (using [catch](https://github.com/philsquared/Catch)). Tests are implememted in separated executabels/subdirs which get executed during compilation incrementally .. compilation fails if a test fails ..

## Build Dependencies
To succesfully build on ubuntu 14.04/trusty OS: 

    sudo apt-get install qt5-default qt5-qmake catch

## Build Instructions

    qmake
    make

Travis build state: [![Build Status](https://travis-ci.org/mxklb/cuteproject.svg?branch=master)](https://travis-ci.org/mxklb/cuteproject)