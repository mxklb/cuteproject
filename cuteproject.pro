TEMPLATE = subdirs
#CONFIG += ordered
CONFIG += catchTests

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
catchTests { include(alltests.pri) }
