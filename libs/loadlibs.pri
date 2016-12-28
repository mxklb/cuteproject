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

for(lib, customLibs) {
    !isEmpty(lib) {
        #message("$${TARGET} loading lib $${lib}")
        LIBDIR = $$clean_path($$dirname(lib))
        LIBNAME = $$basename(lib)
        #message(LIBDIR $${LIBDIR})

        INCLUDEPATH += $$LIBDIR/src
        DEPENDPATH += $$LIBDIR/src
        #message($${INCLUDEPATH})

        LIB_EXTENSION = $$QMAKE_EXTENSION_SHLIB
        isEmpty(LIB_EXTENSION){
            win32: LIB_EXTENSION = dll
            macx:  LIB_EXTENSION = dylib
            else:  LIB_EXTENSION = so
        }
        #message($${LIB_EXTENSION})

        LIBS += -L$${LIBDIR}/ -l$${LIBNAME}
        PRE_TARGETDEPS += $${LIBDIR}/lib$${LIBNAME}.$${LIB_EXTENSION}

        # This is for local unix linking executable started in terminal..
        QMAKE_LFLAGS += "-Wl,-rpath,\'\$$ORIGIN/$$LIBDIR\'"
    }
}

#message( - linker = $${LIBS})
#message( - includepath = $${INCLUDEPATH})
#message( - pretargetdepends = $${PRE_TARGETDEPS})
#message( - qmakeflags = $${QMAKE_LFLAGS})
