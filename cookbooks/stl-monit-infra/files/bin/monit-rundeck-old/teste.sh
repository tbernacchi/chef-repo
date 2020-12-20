#!/usr/bin/env bash

PRJ="Dfin"

		export RUNDECK_URL="http://rundeck.tabajara.local:4440/api/20/project/$PRJ/executions?authtoken="
		export RUNDECK_TOKEN="ixWUqfl9WwHxQ1inFEHbRDVXMF4nt4R2"
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
