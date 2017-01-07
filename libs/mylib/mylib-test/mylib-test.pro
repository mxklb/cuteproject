TARGET = mylib-test
SOURCES += main.cpp

include($$PROJECT_DIR/libs/test.pri)

# Relative path to libs
customLibs = ../mylib

# Load and link all libs
include($$PROJECT_DIR/libs/loadlibs.pri)
