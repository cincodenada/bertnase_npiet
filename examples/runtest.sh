#!/bin/bash


## broken since v1.1:

for f in nprime.??? loop.??? nhello.??? ; do
  echo "**"
  echo "** running: npiet $f:"
  echo "**"
  echo -- output start --
  if [ $f = nprime.gif ] ; then
      echo 991 | ../npiet -v1 $f
  elif [ $f = nprime.ppm ] ; then
      echo 1000 | ../npiet -v1 $f
  else
      ../npiet -v1 $f
      fi
  echo -- output end --
  echo
done

for f in hi.??? nfib.??? ; do
  echo "**"
  echo "** running: npiet $f:"
  echo "**"
  echo -- output start --
  ../npiet $f
  echo -- output end --
  echo
done
