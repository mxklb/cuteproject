# Set test apps
SUBDIRS += \
    mylib-test \
    otherlib-test

# Set test apps directories
mylib-test.subdir = libs/mylib/mylib-test
otherlib-test.subdir = libs/otherlib/otherlib-test

# Setup test dependencies
mylib-test.depends = mylib
otherlib-test.depends = otherlib
