# Load this from any subproject to link shared libs properly and easy.
#
# Takes a list of paths of shared libs (customLibs). The used list must
# contain 'path/to/lib/name's with path/to/lib relative to the caller.
#
# Note: The variable SRC_DIR must be set by the caller to its $PWD.
#
# Example:
# - customLibs = ../path/to/lib/mylib ../other/path/to/otherlib
# - include(loadlibs.pri)
#
# SOURCE and HEADER files must be in each ../path/to/lib/src folder!
#
# Note: include(loadlibs.pri) will setup all given custom libs ->
# -> INCLUDEPATH, DEPENDPATH, LIBS, PRE_TARGETDEPS & QMAKE_LFLAGS.

QMAKE_PROJECT_DEPTH = 0 # Forces absolute paths

for(lib, customLibs) {
    !isEmpty(lib) {
        LIBDIR = $$clean_path($$dirname(lib))
        LIBNAME = $$basename(lib)
        #message("$${TARGET} is loading $$LIBNAME -> from: $$LIBDIR")

        INCLUDEPATH += $$clean_path($$SRC_DIR/$$LIBDIR/src)
        DEPENDPATH += $$clean_path($$SRC_DIR/$$LIBDIR/src)
        #message($${INCLUDEPATH})

        LIB_EXTENSION = $$QMAKE_EXTENSION_SHLIB
        isEmpty(LIB_EXTENSION) {
            win32: LIB_EXTENSION = dll
            macx:  LIB_EXTENSION = dylib
            else:  LIB_EXTENSION = so
        }
        #message($${LIB_EXTENSION})

        # Get dynamic lib binary directory
        OUTDIR = $$clean_path($$OUT_PWD/$${LIBDIR})

        macx {
            frameworks += $$files($${OUTDIR}/$${LIBNAME}.framework)
            LIBS += -F$${OUTDIR}/ -framework $${LIBNAME}
            PRE_TARGETDEPS += $${OUTDIR}/$${LIBNAME}.framework
            INCLUDEPATH += -F$${LIBDIR}
        }
        else {
            LIBS += -L$${OUTDIR}/ -l$${LIBNAME}
            PRE_TARGETDEPS += $${OUTDIR}/lib$${LIBNAME}.$${LIB_EXTENSION}
            QMAKE_LFLAGS += "-Wl,-rpath,\'$$OUTDIR\'"
        }
    }
}

macx { # Deploy all linked frameworks to target bundle
    APP_LIB_FILES.files = $$frameworks
    APP_LIB_FILES.path = Contents/Frameworks/
    QMAKE_BUNDLE_DATA += APP_LIB_FILES
}
