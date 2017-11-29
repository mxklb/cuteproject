CONFIG(debug, debug|release) {
    WINDIR = debug
}
CONFIG(release, debug|release) {
    WINDIR = release
}
