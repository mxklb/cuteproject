# If there is no version tag in git this one will be used
VERSION = 1.0.0

# Need to discard STDERR so get path to NULL device
win32 {
    NULL_DEVICE = NUL # Windows doesn't have /dev/null but has NUL
} else {
    NULL_DEVICE = /dev/null
}

# Need to call git with manually specified paths to repository
BASE_GIT_COMMAND = git --git-dir $$PWD/../.git --work-tree $$PWD

# Trying to get version from git tag / revision
GIT_VERSION = $$system($$BASE_GIT_COMMAND describe --long 2> $$NULL_DEVICE)
isEmpty(GIT_VERSION) {
    GIT_HASH = $$system($$BASE_GIT_COMMAND rev-parse --short HEAD 2> $$NULL_DEVICE)
    GIT_VERSION = $$VERSION-0-$$GIT_HASH
}

# Turns describe output like 0.1.5-42-g652c397 into "0.1.5.42.652c397"
GIT_VERSION ~= s/-/"."
GIT_VERSION ~= s/g/""

# Now we are ready to pass parsed version to Qt
VERSION = $$GIT_VERSION
win32 { # On windows version can only be numerical so remove commit hash
    VERSION ~= s/\.\d+\.[a-f0-9]{6,}//
}

# Adding C preprocessor #DEFINE so we can use it in C++ code
# also here we want full version on every system so using GIT_VERSION
DEFINES += GIT_VERSION=\\\"$$GIT_VERSION\\\"

# By default Qt only uses major and minor version for Info.plist on Mac.
# This will rewrite Info.plist with full version
#macx {
#    INFO_PLIST_PATH = $$shell_quote($${OUT_PWD}/$${TARGET}.app/Contents/Info.plist)
#    QMAKE_POST_LINK += /usr/libexec/PlistBuddy -c \"Add :CFBundleVersion string $${VERSION}\" $${INFO_PLIST_PATH}
#    QMAKE_POST_LINK += /usr/libexec/PlistBuddy -c \"Add :CFBundleShortVersionString string $${VERSION}\" $${INFO_PLIST_PATH}
#    QMAKE_POST_LINK += /usr/libexec/PlistBuddy -c \"Delete :CFBundleGetInfoString\" $${INFO_PLIST_PATH}
#}
