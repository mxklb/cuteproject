# Common template used by all custom libs
# Note: Use this after declaring HEADERS & SOURCE!
TEMPLATE = lib

CONFIG += console
CONFIG -= qt

include($$PWD/osx.pri)
include($$PWD/gcov.pri)
