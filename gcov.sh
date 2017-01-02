#!/bin/bash
execdir=${PWD}
for gcdafile in `ls -d $(find .) | egrep '\.gcda'`; 
do 
  filename=${gcdafile##*/}
  filename=${filename::-4}
  cppfile=$filename"cpp"
  gcnofile=$filename"gcno"
  filedir=$(dirname "${gcdafile}")
  
  # Hack to move wrongly placed gcno and gcda files
  if [ ! -f "$filedir/$cppfile" ]; then
    if [ -f "$filedir/src/$cppfile" ]; then  
      mv "$gcdafile" "$filedir/src/"
      mv "$filedir/$gcnofile" "$filedir/src/"
      echo "Moved files to $filedir/src/"
    else
      echo "Could not find $filedir/$cppfile"
    fi
  else  
    echo $filedir/$cppfile
  fi
  #cd $(dirname "$filedir/$cppfile")
  #gcov -r -n -o . $cppfile > /dev/null;
  #cd $execdir
done
