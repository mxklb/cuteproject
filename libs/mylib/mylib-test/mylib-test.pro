TARGET = mylib-test
SOURCES += main.cpp
SRC_DIR = $$PWD

include(../../tests.pri)

# Set name of libs /path/to/lib/name
customLibs = ../mylib

# Load and link all libs
include(../../loadlibs.pri)
