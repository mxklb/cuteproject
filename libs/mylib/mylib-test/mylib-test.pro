TARGET = mylib-test
SOURCES += main.cpp

include(../../tests.pri)

# Set name of libs /path/to/lib/name
customLibs = $$PWD/../mylib

# Load and link all libs
include(../../loadlibs.pri)
