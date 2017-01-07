# Common template used by all custom libs.
# Creates a TARGET.pri with depend- and includepath
# to be used later on during lib load loadlibs.pri!
# Note: Use this after declaring HEADERS & SOURCE!
TEMPLATE = lib

CONFIG += console
CONFIG -= qt

include($$PWD/osx.pri)
include($$PWD/coverage.pri)

# Create TARGET.pri file
libPriFile = $$_PRO_FILE_PWD_/$${TARGET}.pri

# Prepare for distclean
QMAKE_DISTCLEAN += $$libPriFile

system(touch $${libPriFile})
system(echo "INCLUDEPATH+=\\$\\$PWD" > $${libPriFile})
system(echo "DEPENDPATH+=\\$\\$PWD" >> $${libPriFile})

# Add all headers path
for(header, HEADERS) {
    includePath = "INCLUDEPATH+=\\$\\$PWD/"$$dirname(header)
    dependPath = "DEPENDPATH+=\\$\\$PWD/"$$dirname(header)
    system(cat $${libPriFile} | grep "$$includePath" | grep -q ^ && echo "" >/dev/null 2>&1 || echo "$$includePath" >> $${libPriFile})
    system(cat $${libPriFile} | grep "$$dependPath" | grep -q ^ && echo "" >/dev/null 2>&1 || echo "$$dependPath" >> $${libPriFile})
}

# Add non existant source path
for(source, SOURCES) {
    includePath = "INCLUDEPATH+=\\$\\$PWD/"$$dirname(source)
    dependPath = "DEPENDPATH+=\\$\\$PWD/"$$dirname(source)
    system(cat $${libPriFile} | grep "$$includePath" | grep -q ^ && echo "" >/dev/null 2>&1 || echo "$$includePath" >> $${libPriFile})
    system(cat $${libPriFile} | grep "$$dependPath" | grep -q ^ && echo "" >/dev/null 2>&1 || echo "$$dependPath" >> $${libPriFile})
}
