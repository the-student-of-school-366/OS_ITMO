#!/bin/bash

if [ -f "/var/log/anaconda/X.log" ]; then
    source_file="/var/log/anaconda/X.log"
elif [ -f "/var/log/installer/X.0.log" ]; then
    source_file="/var/log/installer/X.0.log"
else
    echo "Error, both files are not exist"
    exit 1
fi

{
    grep "WARNING" "$source_file" | sed 's/WARNING/Warning:/'
    grep "INFO" "$source_file" | sed 's/INFO/Information:/'
} > full.log

cat full.log