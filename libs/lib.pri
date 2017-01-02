# Common template used by all custom libs
# Note: Use this after declaring HEADERS & SOURCE!
TEMPLATE = lib

CONFIG += console
CONFIG -= qt

macx: include($$PWD/osx.pri)

unix:!macx:catchTests {
    QMAKE_CXXFLAGS += -g -fprofile-arcs -ftest-coverage
    QMAKE_LFLAGS += -lgcov --coverage
}