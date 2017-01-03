TARGET = otherlib-test
SOURCES += $$PWD/main.cpp

include(../../tests.pri)

# Set name of libs /path/to/lib/name
customLibs = ../otherlib

# Load and link all libs
include(../../loadlibs.pri)
