CONFIG += console
CONFIG -= qt

TEMPLATE = lib
TARGET = otherlib

SOURCES += src/otherclass.cpp
HEADERS += src/otherclass.h

macx: include(../osx.pri)
