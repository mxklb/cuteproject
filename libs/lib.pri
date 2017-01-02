# Common template used by all custom libs
# Note: Use this after declaring HEADERS & SOURCE!
TEMPLATE = lib

CONFIG += console
CONFIG -= qt

macx: include($$PWD/osx.pri)

catchTests {
    QMAKE_CXXFLAGS += -coverage
    QMAKE_LFLAGS += -lgcov --coverage
}
