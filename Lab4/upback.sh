#!/bin/bash

HOM="/home/user/ananda/lab4/"
restore="$HOM/restore"

if [[ -d $restore ]]
then
        rm -r $restore
fi

lastBackupDate=$(ls $HOM | grep -E "^Backup-" | sort -n | tail -1 | sed 's/^Backup-//')
lastBackup="$HOM/Backup-${lastBackupDate}"

if [[ -z "$lastBackupDate" ]]
then
        echo "Backups not found, run previous script"
        exit 1
fi

mkdir $restore

for file in "$lastBackup"/*
do
  file=$(basename "$file")
  file=$(echo "$file" | grep -E -v "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$")
  if [[ ! -z "$file" ]]
  then
 cp "$lastBackup/$file" "$restore/$file"
  fi
done

