# Common config for test executables
# Usage: Just include this for test apps.
TEMPLATE = app

CONFIG += console
CONFIG += c++14

# Set catch header include path
INCLUDEPATH += $$PWD/extern/catch

# Trigger execution of the test target
win32: QMAKE_POST_LINK=$${TARGET}.exe
macx:  QMAKE_POST_LINK=$$OUT_PWD/$${TARGET}.app/Contents/MacOS/$${TARGET}>&2
else:  QMAKE_POST_LINK=$$OUT_PWD/$$TARGET>&2
