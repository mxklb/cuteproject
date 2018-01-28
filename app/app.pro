TEMPLATE = app
TARGET = cuteproject

CONFIG += console
CONFIG += qt
QT += core gui
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

SOURCES += main.cpp \
    form.cpp

FORMS += form.ui
HEADERS += form.h

# Relative path to libs
customLibs = ../libs/mylib/mylib
customLibs += ../libs/otherlib/otherlib

# Load and link these custom libs
include(../libs/loadlibs.pri)

# Set application icon
ICON = ../img/cuteproject.svg
macx: ICON = ../img/logo.icns
win32: RC_ICONS += ../img/logo.ico

RESOURCES += app.qrc

unix:!macx {
    shortcutfiles.files = ../pkgs/appimage/cuteproject.desktop
    shortcutfiles.path = $$[QT_INSTALL_PREFIX]/share/applications/
    INSTALLS += shortcutfiles

    data.files += ../img/cuteproject.svg
    data.path = $$[QT_INSTALL_PREFIX]/share/pixmaps/
    INSTALLS += data

    target.files += $$OUT_PWD/$$TARGET
    target.path = $$[QT_INSTALL_PREFIX]/bin
    INSTALLS += target
}
