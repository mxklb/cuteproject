# Include this to compile for code coverage (gcov)
contains(catchTests, true) {
    CONFIG(debug, debug|release) {
        unix:!macx {
            message(Activating gcov coverage compiler flags -> $$TARGET)
            QMAKE_CXXFLAGS += -fprofile-arcs -ftest-coverage
            QMAKE_LFLAGS += -lgcov --coverage
        }
    }
}
