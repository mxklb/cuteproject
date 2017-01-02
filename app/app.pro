TEMPLATE = app
TARGET = app

CONFIG += console
CONFIG -= qt

SOURCES += $$PWD/main.cpp

# Set name of libs /path/to/lib/name
customLibs = $$PWD/../libs/mylib/mylib
customLibs += $$PWD/../libs/otherlib/otherlib

# Load and link all custom libs
include(../libs/loadlibs.pri)
