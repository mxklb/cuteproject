unix:!macx {
    QMAKE_CXXFLAGS += -g -fprofile-arcs -ftest-coverage
    QMAKE_LFLAGS += -lgcov --coverage
}
