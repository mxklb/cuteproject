TARGET = mylib-test
SOURCES += main.cpp

include($$PROJECT_DIR/libs/test.pri)

# Set name of libs /path/to/lib/name
customLibs = ../mylib

# Load and link all libs
include($$PROJECT_DIR/libs/loadlibs.pri)
