#!/bin/bash

user_name="ananda"
process_count=$(ps -u "$user_name" --no-header | wc -l)
echo "Number of user process: $process_count" > process.txt
ps -u "$user_name" -o pid,args --no-header >> process.txt
echo "Information about process added to processes.txt"