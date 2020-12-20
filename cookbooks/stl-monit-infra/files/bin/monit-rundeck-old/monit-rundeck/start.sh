#!/usr/bin/env bash

# Lista
PRJS=`curl -s -H "Accept: application/json" -X GET "http://rundeck.tabajara.intranet/api/1/projects?authtoken=QDHs9DW4FZpkUUOYz8DrbpmUO3TF0epG" | jq . | grep "name" | awk '{ print $2 }' | sed -e 's/"//g' -e 's/,//g' | sort -u`

for PRJ in `echo $PRJS`
	do
		export RUNDECK_URL="http://rundeck.tabajara.intranet/api/20/project/$PRJ/executions?authtoken=QDHs9DW4FZpkUUOYz8DrbpmUO3TF0epG"
		export RUNDECK_TOKEN="QDHs9DW4FZpkUUOYz8DrbpmUO3TF0epG"
		export RUNDECK_FILE_PATH="/tmp/rundeck-$PRJ-stats.txt"
		export TIME_ELAPSED=300
		export PYTHONIOENCODING=utf8

		SERVICE='rundeck.py'

		if ps ax | grep -v grep | grep ${SERVICE} > /dev/null
			then
				echo "$SERVICE service running, everything is fine"
			else
				echo "$SERVICE is not running"
				echo "Rundeck service"
				python /usr/local/bin/monit-rundeck/rundeck.py
		fi
	done
