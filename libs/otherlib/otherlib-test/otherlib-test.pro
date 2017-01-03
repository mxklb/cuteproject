TARGET = otherlib-test
SOURCES += main.cpp
SRC_DIR = $$PWD

include(../../tests.pri)

# Set name of libs /path/to/lib/name
customLibs = ../otherlib

# Load and link all libs
include(../../loadlibs.pri)
