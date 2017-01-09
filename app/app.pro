TEMPLATE = app
TARGET = app

CONFIG += console
CONFIG -= qt

SOURCES += main.cpp

# Relative path to libs
customLibs = ../libs/mylib/mylib
customLibs += ../libs/otherlib/otherlib

# Load and link these custom libs
include($$PROJECT_DIR/libs/loadlibs.pri)

unix:!macx {
    target.files += $$OUT_PWD/$$TARGET
    target.path = $$[QT_INSTALL_PREFIX]/bin
    INSTALLS += target
}