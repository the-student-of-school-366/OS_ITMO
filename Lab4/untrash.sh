#!/bin/bash

DIR="/home/user/ananda/lab4/.trash"
LOG="/home/user/ananda/lab4/.trash.log"
HOM="/home/user/ananda/lab4"

if [ $# -ne 1 ]
then
  echo "Invalid arguments"
  exit 1
fi

if [[ ! -d $DIR ]]
then
    echo "Hide directory not found"
    exit 1
fi

if [[ ! -f $LOG ]]
then
    echo "Hide log file not found"
    exit 1
fi

for i in $(grep "$1" $LOG | awk '{print $NF}')
do
    fileName=$(grep $i $LOG | awk '{$NF=""; print $0}')
    fileName=$(echo "$fileName" | sed 's/ *$//')
    read -p "${fileName} Are you sure?: [y/n] " ans

    case "$ans" in
        "y")
            newFileName=""
            id=$i
            fileDir=$(echo "$fileName" | awk 'BEGIN{FS=OFS="/"}; {$NF=""; print $0}')
            restoredFile=$(echo "$fileName" | awk 'BEGIN{FS="/"}; {print $NF}')

            if [[ ! -d $fileDir ]]
            then

                echo "Directory ${fileDir} didnt found. File \"${restoredFile}\" restored in home dir"
                if [[ -f "${HOM}/${restoredFile}" ]]
                then
                    read -p "File \"${HOM}/${restoredFile}\" already exist. Create new name: " newFileName
                    ln "${DIR}/${id}" "${HOM}/${newFileName}"
                    rm "${DIR}/${id}"
                else
                    ln "${DIR}/${id}" "${HOM}/${restoredFile}"
                    rm "${DIR}/${id}"
                fi
            else

                if [[ -f "${fileName}" ]]
                then
                    read -p "File \"${fileName}\" already exist. Create new name: " newFileName
                    ln "${DIR}/${id}" "${fileDir}/${newFileName}"
                    rm "${DIR}/${id}"
                else
                    ln "${DIR}/${id}" "${fileName}"
                    rm "${DIR}/${id}"
                fi
            fi

            sed "/${i}/d" $LOG > .trash.log2 && mv .trash.log2 $LOG
            echo "OK!"
            continue
        ;;

        *)
            continue
        ;;
    esac
done
