#!/bin/bash

if [ -f "/var/log/anaconda/syslog" ]; then
    source_file="/var/log/anaconda/syslog"
elif [ -f "/var/log/installer/syslog" ]; then
    source_file="/var/log/installer/syslog"
else
    echo "Error, both files are not exist"
    exit 1
fi

awk '$2 == "INFO" {print}' "$source_file" > info.log

echo "File created"