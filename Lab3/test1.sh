#!/bin/bash
datime=$(date '+%F_%T')
mkdir ~/test && {
echo "catalog test was created successfully" > ~/report
touch ~/test/$datime
}

ping www.net_nikogo.ru || echo "$datime This host is not available" >> ~/report
