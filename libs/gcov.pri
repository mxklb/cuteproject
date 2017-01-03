# Include this to get code coverage from gcov
CONFIG(debug, debug|release) {
    contains(catchTests, true) {
        unix:!macx {
            message(Activating gcov coverage compiler flags)
            QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage
            QMAKE_LFLAGS += -lgcov --coverage
        }
    }
}
