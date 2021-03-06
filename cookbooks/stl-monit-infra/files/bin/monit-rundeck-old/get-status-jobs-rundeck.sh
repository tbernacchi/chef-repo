#!/bin/bash

# Script para obter o status dos jobs do rundeck

TEMPLATE_ID="11316"
TEMPLATE_NAME="Servicos-Core-Jobs-Rundeck"

GRP_ID="148"
GRP_NAME="jobs-rundeck"

JSON_AUTH=`mktemp --suffix=-ZABBIX-JOBS-AUTH`
JSON_HOST=`mktemp --suffix=-ZABBIX-JOBS`

# Endpoint do Zabbix
ZABBIX_API="http://zabbix.tabajara.intranet/zabbix/api_jsonrpc.php"

# Usuari0 e senha no zabbix e jira
USER="svc_zabbix_monit"
PASS="kwf4384R?"
ZBXPRX="zbxprx01.tabajara.local"
PRX_ID="10254"

# LOCKFILE
LOCK="/tmp/get-rundeck.lck"

# LOCK
fn_check_lock()
	{
	if [ -e $LOCK ]
		then
			echo "Arquivo de lock $LOCK encontrado, saindo..."
			exit 0
		else
		echo $$ > $LOCK
		# Execute
		fn_host_create
		fn_exec_python
		fn_make_msg
		fn_gc
	fi
	}

# O corpo do JSON para verificar e salva o COOKIE de autenticacao no Zabbix (usuario svc_zabbix_monit e senha kwf4384R?)

fn_host_create()
	{
cat > $JSON_AUTH <<END
{
	"jsonrpc": "2.0",
	"method": "user.login",
	"params": {
		"user": "$USER",
		"password": "$PASS"
	},
	"id": 1,
	"auth": null
}

END

	# Fazendo o post e salvando o cookie
	COOKIE=`curl -s -i -X POST -H 'Content-Type:application/json' -d@$JSON_AUTH $ZABBIX_API | tail -n1 | cut -f8 -d\"`

	# Lista
	PRJS=`curl -s -H "Accept: application/json" -X GET "http://rundeck.tabajara.intranet/api/1/projects?authtoken=QDHs9DW4FZpkUUOYz8DrbpmUO3TF0epG" | jq . | grep "name" | awk '{ print $2 }' | sed -e 's/"//g' -e 's/,//g' | sort -u`

	for prj in `echo $PRJS`
		do
			JOBS=`curl -s -H "Accept: application/json" -X GET "http://rundeck.tabajara.intranet/api/20/project/$prj/executions?authtoken=QDHs9DW4FZpkUUOYz8DrbpmUO3TF0epG" | jq . | grep "name" | awk '{ print $2 }' | sed -e 's/"//g' -e 's/,//g' | sort -u`

			for JOB in `echo $JOBS`
				do

cat > $JSON_HOST <<END
{
    "jsonrpc": "2.0",
    "method": "host.create",
    "params": {
        "host": "job-$JOB",
        "interfaces": [
            {
                "type": 1,
                "main": 1,
                "useip": 1,
                "ip": "127.0.0.1",
                "dns": "job-$JOB",
                "port": "10050"
            }
        ],
        "groups": [
            {
                "groupid": "$GRP_ID"
            }
        ],
        "templates": [
            {
                "templateid": "$TEMPLATE_ID"
            }
        ]
    },
        "id": 1,
        "auth": "$COOKIE"
}
END

				# Criando os hosts no Zabbix
				curl -s -i -H 'Content-Type: application/json-rpc' -d@$JSON_HOST $ZABBIX_API 
				sleep 1

				# como zabbix nao tem criacao com o proxy - update na seq
				WS_UPDATE="http://zabbix.tabajara.local/zabbix-balancer/ws/update-zabbix-proxy.php"

				# Executando o update
				curl --data "proxy_hostid=$PRX_ID&host=job-$JOB" -X POST $WS_UPDATE
				sleep 1
			done
		done
}

fn_exec_python()
	{
	# Preparando para enviar os dados para o Zabbix
	# Executando o python criado pelo Leandro (leco)
	sh /usr/local/bin/monit-rundeck/start.sh
	}

fn_send_zabbix()
	{
	## Agente de envio
	ZBXPRX="zbxprx01.tabajara.local"
	ZBXSND=$(which zabbix_sender)

	$ZBXSND -z $ZBXPRX -s $job_name -k $KEY -o "$MSG"
	}

fn_make_msg()
	{
	LIST_FILE=`ls /tmp/ | grep rundeck-`

	for FILE in `echo $LIST_FILE`
		do
			for JOB in `cat /tmp/$FILE  | awk '{ print $3 }'`
				do
					job_name="job-$JOB"

					# Coleta e envia o status
					STATUS=`cat /tmp/$FILE | grep $JOB | awk '{ print $4 }'`
					MSG="$STATUS"
					KEY="job-status"
					fn_send_zabbix

					# Coleta e envia o time
					TIME=`cat /tmp/$FILE | grep $JOB | awk '{ print $8 }'`
					MSG="$TIME"
					KEY="job-time"
					fn_send_zabbix
				done
		done
	}

fn_gc()
	{
	# Remove os temps
	rm -f /tmp/*-ZABBIX-JOBS*
	rm -f /tmp/rundeck-*
	rm -f $LOCK
	}

# main
# Execute
fn_check_lock

