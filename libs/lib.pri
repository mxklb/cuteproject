# Common template used by all custom subdir libs.
# Creates a TARGET.pri with depend- and includepath
# to be used later on during loadlibs.pri include!
# Note: Use this after declaring HEADERS & SOURCE!
TEMPLATE = lib

CONFIG += console
CONFIG -= qt

include($$PWD/osx.pri)
include($$PWD/coverage.pri)

unix:!macx {
    libInstall.files += $$OUT_PWD/*.so
    libInstall.files += $$OUT_PWD/*.so.*
    libInstall.path = $$[QT_INSTALL_PREFIX]/lib
    INSTALLS += libInstall
}
