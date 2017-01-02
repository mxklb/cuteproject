CONFIG(debug, debug|release) {
    DESTDIR=$$OUT_PWD/debug
} else {
    DESTDIR=$$OUT_PWD/release
}

UI_DIR = $${DESTDIR}/uics
RCC_DIR = $${DESTDIR}/rcc
MOC_DIR = $${DESTDIR}/mocs
OBJECTS_DIR = $${DESTDIR}/objs
