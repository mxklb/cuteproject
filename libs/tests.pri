# Common config for test execution
# Usage: Just include this for test apps.

CONFIG += console
CONFIG += c++14

# Trigger execution of the test target
win32: QMAKE_POST_LINK=$${TARGET}.exe
macx:  QMAKE_POST_LINK=$$OUT_PWD/$${TARGET}.app/Contents/MacOS/$${TARGET}>&2
else:  QMAKE_POST_LINK=./$$TARGET>&2
