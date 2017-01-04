#UI_DIR = $${DESTDIR}/uics
#RCC_DIR = $${DESTDIR}/rcc
#MOC_DIR = $${DESTDIR}/mocs
#OBJECTS_DIR = $${DESTDIR}/objs

CONFIG(release, debug|release) {
    FORCECONFIG=release
}

contains(FORCECONFIG, release) {
    CONFIG += release
    CONFIG -= debug
    #DEFINES += QT_NO_DEBUG_OUTPUT
} else {
    CONFIG -= release
    CONFIG += debug
}
