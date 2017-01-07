TARGET = otherlib-test
SOURCES += main.cpp

include($$PROJECT_DIR/libs/test.pri)

# Relative path to libs
customLibs = ../otherlib

# Load and link all libs
include($$PROJECT_DIR/libs/loadlibs.pri)
