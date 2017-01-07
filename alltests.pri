# Register tests to run
SUBDIRS += \
    mylib-test \
    otherlib-test

# Set test apps directories
mylib-test.subdir = libs/mylib/mylib-test
otherlib-test.subdir = libs/otherlib/otherlib-test

# Setup test dependencies
mylib-test.depends = mylib
otherlib-test.depends = otherlib

# Setup app dependencies to tests
app.depends += mylib-test otherlib-test