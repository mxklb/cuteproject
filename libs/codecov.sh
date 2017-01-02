#!/bin/bash
execdir=${PWD}
for filepath in `find . | egrep '\.gcno'`; 
do 
  cppfile=${filepath##*/}
  cppfile=${cppfile::-4}
  cppfile=$cppfile"cpp"
  filedir=$(dirname "${filepath}")
  cd $filedir
  gcov -r -n -o . $cppfile 
  cd $execdir
done
