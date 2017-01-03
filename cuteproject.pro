TEMPLATE = subdirs
#CONFIG += ordered

include(common.pri)

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
    message(Building source including tests ($$catchTests))
    include(alltests.pri)
}
