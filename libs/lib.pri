# Common template used by all custom libs
# Note: Use this after declaring HEADERS & SOURCE!
TEMPLATE = lib

CONFIG += console
CONFIG -= qt

macx: include($$PWD/osx.pri)

