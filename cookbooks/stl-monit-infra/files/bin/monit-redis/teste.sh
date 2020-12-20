#!/bin/sh

input="/tmp/redis-log.tmp-quintal01.tabajara.intranet"

while IFS= read -r line
do
  KEY=`echo $line | awk -F',' '{ print $1 }'`
  VALUE=`echo $line | awk -F',' '{ print $2 }'`

  echo "KEY $KEY e VALUE $VALUE"
done < "$input"
