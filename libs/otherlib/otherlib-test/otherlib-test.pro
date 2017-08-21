TARGET = otherlib-test
SOURCES += main.cpp

include(../../test.pri)

# Relative path to libs
customLibs = ../otherlib

# Load and link all libs
include(../../loadlibs.pri)
