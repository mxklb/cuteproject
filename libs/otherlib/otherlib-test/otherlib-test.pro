TARGET = otherlib-test
SOURCES += $$PWD/main.cpp

include(../../tests.pri)

# Set name of libs /path/to/lib/name
customLibs = $$PWD/../otherlib

# Load and link all libs
include(../../loadlibs.pri)
