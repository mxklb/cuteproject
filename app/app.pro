TEMPLATE = app
TARGET = app

CONFIG += console
CONFIG -= qt

SOURCES += main.cpp

# This apps source dir
SRC_DIR = $$PWD

# Set name of libs ../rel/path/to/lib/name
customLibs = ../libs/mylib/mylib
customLibs += ../libs/otherlib/otherlib

# Load and link these custom libs
include($$PROJECT_DIR/libs/loadlibs.pri)
