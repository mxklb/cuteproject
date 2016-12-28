TEMPLATE = app
TARGET = mylib-test

SOURCES += main.cpp

include(../../tests.pri)

# Set name of libs /path/to/lib/name
customLibs = ../mylib

# Load and link all libs
include(../../loadlibs.pri)
