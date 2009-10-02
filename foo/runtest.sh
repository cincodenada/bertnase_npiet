#!/bin/bash

maxe=10000000

if [ "$1" = "-g" ] ; then
  gen=1
  shift
fi

if [ "$1" != "" ] ; then
  ../npiet-foogol -q $1
  if [ "$gen" = 1 ] ; then
    ../npiet -e $maxe npiet-foogol.png >& `basename $1 .foo`.out
    ls -l `basename $1 .foo`.out
  else
    ../npiet -e $maxe -tpic -te 1000 npiet-foogol.png
  fi

  exit 0
fi


for f in *.foo ; do
  b=`basename $f .foo`

  echo running test $f
  fail=0

  for t in 10240 2048 1024 222 128 66 48 24 23 22 16 15 14 13 12 11 10 ; do

    if [ $fail = 0 ] ; then
      targ="-w $t"

      ../npiet-foogol -q $targ $f > /tmp/$b-tmp-$t.out
      ../npiet -e $maxe npiet-foogol.png </dev/null >> /tmp/$b-tmp-$t.out
      if diff -q $b.out /tmp/$b-tmp-$t.out >/dev/null ; then
	rm -f ./a.out 2>/dev/null
	## check against foogol if avail:
	# ( foogol $f $b.c || fc $f $b.c ) && gcc $b.c \
	#	&& ./a.out > /tmp/$b-tmp-$t.out \
	#	&& diff -q $b.out /tmp/$b-tmp-$t.out >/dev/null \
	#	&& echo ==== file=$f wrap=$t foogol diff ==== \
	#	&& diff -u $b.out /tmp/$b-tmp-$t.out
      else
        echo ==== file=$f wrap=$t ====
        diff -u $b.out /tmp/$b-tmp-$t.out
        fail=1
      fi
      rm -f /tmp/$b-tmp-$t.out
    fi

  done

done
