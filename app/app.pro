TEMPLATE = app
TARGET = app

CONFIG += console
CONFIG -= qt

SOURCES += main.cpp
SRC_DIR = $$PWD

# Set name of libs /path/to/lib/name
customLibs = ../libs/mylib/mylib
customLibs += ../libs/otherlib/otherlib

# Load and link all custom libs
include(../libs/loadlibs.pri)
