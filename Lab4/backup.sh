#!/bin/bash

#!/bin/bash

HOM="/home/user/ananda/lab4"
report="$HOM/backup-report"

lastBackupDate=$(ls $HOM | grep -E "^Backup-" | sort -n | tail -1 | sed "s/Backup-//")
lastBackup="$HOM/Backup-${lastBackupDate}"
lastBackupTimes=$(date -d "$lastBackupDate" +"%s")

today=$(date +"%Y-%m-%d")
currentTime=$(date -d "$today" +"%s")

totalTime=$(echo "(${currentTime} - ${lastBackupTimes}) / 60 / 60 / 24" | bc)
flag=0
if [[ $totalTime > 7 || -z "$lastBackupDate" ]]
then
        flag=1
fi

if [[ flag -eq 1 ]]
then
        backup="$HOM/Backup-${today}"
        source="$HOM/source"

        mkdir $backup

        for file in $HOM/source/*
        do
            if [[ -f "$file" ]]
     then
  file=$(basename "$file")
  cp "$source/$file" "$backup"
     fi
        done

        fileList=$(ls $source | sed "s/^/\t/")

        echo -e "${today} Created: \n -${fileList}" >> $report

else
        source="$HOM/source"
        changes=""

        for file in $HOM/source/*
        do
  file=$(basename "$file")
  #echo "AYYYYYYY"
  if [[ ! -f "$lastBackup/$file" ]]
                then
   echo "Cant backup directory"
                        #cp "$source/$file" $lastBackup
                        #changes="${changes}\n\t$file"
   continue
                else
                        sourceSize=$(wc -c "$source/$file" | awk '{print $1}')
                        backupSize=$(wc -c "$lastBackup/$file" | awk '{print $1}')

                        if [[ $sourceSize != $backupSize ]]
                        then
                                mv "$lastBackup/$file" "$lastBackup/$file.$today"
                                cp "$source/$file" $lastBackup
                                changes="${changes}\n\t$file ($file.$today)"
                        fi
                fi
        done

        if [[ ! -z "$changes" ]]
        then
            echo -e "${lastBackupDate} Updated: -${changes}" >> $report
        fi
fi
