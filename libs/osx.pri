# Common config for osx libs -> frameworks
# Note: Use this after declaring HEADERS!
macx {
    CONFIG += lib_bundle
    QMAKE_FRAMEWORK_BUNDLE_NAME = $$OUT_PWD/$$TARGET
    #FRAMEWORK_HEADERS.version = Versions
    FRAMEWORK_HEADERS.files = $$HEADERS
    FRAMEWORK_HEADERS.path = Headers
    QMAKE_BUNDLE_DATA += FRAMEWORK_HEADERS
}
