#!/bin/bash
output_file="output2.txt"
ps - eo pid,cmd --no-header | grep -E "^\s*[0-9]+ /sbin/" | awk '{print $1}' > "$output_file"
echo "SUCCESS 2 !!!"