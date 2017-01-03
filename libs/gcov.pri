# Include this to get code coverage from gcov
CONFIG(debug, debug|release) {
    unix:!macx {
        QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage
        QMAKE_LFLAGS += -lgcov --coverage
    }
}
