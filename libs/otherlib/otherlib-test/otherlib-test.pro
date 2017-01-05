TARGET = otherlib-test
SOURCES += main.cpp
SRC_DIR = $$PWD

include($$PROJECT_DIR/libs/test.pri)

# Set name of libs /path/to/lib/name
customLibs = ../otherlib

# Load and link all libs
include($$PROJECT_DIR/libs/loadlibs.pri)
