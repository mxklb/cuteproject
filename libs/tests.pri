# Common config for test execution
# Usage: Just include this for test apps.

CONFIG += console
CONFIG += c++14

# Trigger execute of the test target
unix:QMAKE_POST_LINK=./$$TARGET>&2
win32:QMAKE_POST_LINK=$${TARGET}.exe

!exists(/usr/include/catch.hpp) {
  HEADERS += catch.hpp
}
