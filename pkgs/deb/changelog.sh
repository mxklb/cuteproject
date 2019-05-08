#!/bin/bash
# Prints a debian changelog for all commits since latest release.
# Note: This creates one source version for each commit (chd -U)

project="cuteproject"

# Create changelog since lastest tag/release
gittag=$(git describe --abbrev=0 --tags)
hashes=($(git log --format="%h" $gittag..HEAD))
count=${#hashes[@]}

# Print nothing for tagged commits
if (( $count == 0 )); then
   exit 0
fi

IFS='.' read -a versions <<< "$gittag"

for i in "${!hashes[@]}"; do
  position=$(expr $count - $i)
  printf "$project-${versions[0]}.${versions[1]} (${versions[2]}-$position) unstable; urgency=medium\n\n"
  git log -n 1 --pretty=format:"  * %s%n%n" ${hashes[$i]}
  git log -n 1 --pretty=format:" -- %an <%ae>  %cd%n%n" ${hashes[$i]} --date=rfc
done

exit 0

# Create changlog for all commits and versions :: Author:Andrey Nikishaev
git tag -l | sort -V | tac | while read TAG ; do
    echo
    if [ $NEXT ];then
        printf "\n  * RELEASE v$NEXT\n\n"
    #else
    #    echo "[Current]"
    fi
    GIT_PAGER=cat git log --no-merges --format="  * %s%n" $TAG..$NEXT
    NEXT=$TAG
done
FIRST=$(git tag -l | sort -V | head -1)
echo
printf "\n  * RELEASE v$FIRST\n\n"
GIT_PAGER=cat git log --no-merges --format="  * %s%n" $FIRST
