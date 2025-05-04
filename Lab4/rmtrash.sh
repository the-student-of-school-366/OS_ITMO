#!/bin/bash

tdir=/home/user/ananda/lab4/.trash
tlog=/home/user/ananda/lab4/.trash.log

file="$PWD/$*"


if [[ $# -ne 1 ]]
then
  echo "invalid arguments"
  exit 1
fi

if [[ ! -f "$1" ]]
then
  echo "no such file in this directory"
  exit 1
fi

if [[ -d $1 ]]; then
  echo "Error. it's folder"
  exit 1
fi

if [[ ! -d $tdir ]]
then
  mkdir $tdir
  touch $tlog
fi

data=$(date +"%d-%m-%Y_%T")
cp -rl "$file" "$tdir/$data"
echo "$file" "$data" >> $tlog
rm -rf "$file"