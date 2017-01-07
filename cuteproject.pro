TEMPLATE = subdirs
#CONFIG += ordered

# Sub modules
SUBDIRS = \
    mylib \
    otherlib \
    app

# Set directories
app.subdir = app
mylib.subdir = libs/mylib
otherlib.subdir = libs/otherlib

# Setup app dependencies
app.depends = mylib otherlib

# -- Include all test projects
contains(catchTests, true) {
    include(alltests.pri)
    CONFIG(debug, debug|release) {
        message(Debug build with tests detected!)
    } else {
        message(Release build with tests deteced!)
    }
}
