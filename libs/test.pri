# Common config for test executables
# Usage: Just include this for test apps.
TEMPLATE = app

CONFIG += console
CONFIG += c++14

# Set catch header include path
INCLUDEPATH += $$PWD/extern/catch

# Trigger execution of the test target
win32 {
  CONFIG(debug, debug|release) {
      WINDIR = debug
  }
  CONFIG(release, debug|release) {
      WINDIR = release
  }
  message("--> Windows test execution target: $$OUT_PWD/$${WINDIR}/$${TARGET}.exe")
  QMAKE_POST_LINK = $$system_path($$OUT_PWD/$${WINDIR}/$${TARGET}.exe)
}
macx {
  QMAKE_POST_LINK = $$OUT_PWD/$${TARGET}.app/Contents/MacOS/$${TARGET}>&2
}
unix:!macx {
  QMAKE_POST_LINK = $$OUT_PWD/$$TARGET>&2
}
