#!/bin/bash
# Author:Andrey Nikishaev
git tag -l --sort=v:refname | tac | while read TAG ; do
    echo
    if [ $NEXT ];then
        printf "\n  * RELEASE v$NEXT\n\n"
    #else
    #    echo "[Current]"
    fi
    GIT_PAGER=cat git log --no-merges --format="  * %s%n" $TAG..$NEXT
    NEXT=$TAG
done
FIRST=$(git tag -l --sort=v:refname | head -1)
echo
printf "\n  * RELEASE v$FIRST\n\n"
GIT_PAGER=cat git log --no-merges --format="  * %s%n" $FIRST

# Print commit messages since last tag
#gittag=$(git describe --abbrev=0 --tags)
#git log --no-merges --format="  * %s" $gittag..HEAD
