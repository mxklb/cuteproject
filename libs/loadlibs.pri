# Load this from any subproject to link shared libs properly and easy.
#
# Takes a list of paths of shared libs (customLibs). The used list must
# contain 'path/to/lib/name's with path/to/lib relative to the caller (f.e):
#
# customLibs = ../path/to/lib/mylib ../other/path/to/otherlib
# include(loadlibs.pri)
#
# SOURCE and HEADER files must be in each ../path/to/lib/src folder!
#
# Note: include(loadlibs.pri) will setup all given custom libs ->
# -> INCLUDEPATH, DEPENDPATH, LIBS, PRE_TARGETDEPS & QMAKE_LFLAGS.

QMAKE_PROJECT_DEPTH = 0 # Forces absolute paths

for(lib, customLibs) {
    !isEmpty(lib) {
        #message("$${TARGET} is loading $${lib}")
        LIBDIR = $$clean_path($$dirname(lib))
        LIBNAME = $$basename(lib)
        #message(LIBDIR $${LIBDIR})

        INCLUDEPATH += $$clean_path($$LIBDIR/src)
        DEPENDPATH += $$clean_path($$LIBDIR/src)
        #message($${INCLUDEPATH})

        LIB_EXTENSION = $$QMAKE_EXTENSION_SHLIB
        isEmpty(LIB_EXTENSION) {
            win32: LIB_EXTENSION = dll
            macx:  LIB_EXTENSION = dylib
            else:  LIB_EXTENSION = so
        }
        #message($${LIB_EXTENSION})

        macx {
            LIBDIR = $$clean_path($$OUT_PWD/$${LIBDIR})
            frameworks += $$files($${LIBDIR}/$${LIBNAME}.framework)
            INCLUDEPATH += -F$${LIBDIR}
            LIBS += -F$${LIBDIR}/ -framework $${LIBNAME}
            PRE_TARGETDEPS += $${LIBDIR}/$${LIBNAME}.framework
        }
        else {
            LIBS += -L$${LIBDIR}/ -l$${LIBNAME}
            PRE_TARGETDEPS += $${LIBDIR}/lib$${LIBNAME}.$${LIB_EXTENSION}
            QMAKE_LFLAGS += "-Wl,-rpath,$${LIBDIR}"
        }
    }
}

macx { # Deploy all frameworks to target bundle
    APP_LIB_FILES.files = $$frameworks
    APP_LIB_FILES.path = Contents/Frameworks/
    QMAKE_BUNDLE_DATA += APP_LIB_FILES
}
