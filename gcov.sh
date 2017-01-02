#!/bin/bash
execdir=${PWD}
for filepath in `ls -d $(find .) | egrep '\.gcno'`; 
do 
  cppfile=${filepath##*/}
  cppfile=${cppfile::-4}
  cppfile=$cppfile"cpp"
  filedir=$(dirname "${filepath}")
  echo $filedir/$cppfile 
  cd $(dirname "$filedir/$cppfile")
  gcov -r -n -o . $cppfile 
  cd $execdir
done
