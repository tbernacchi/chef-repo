#!/bin/sh

SERVERS="novoportal01.tabajara.local \
	 novoportal02.tabajara.local \
	 novoportal03.tabajara.intranet \
	 novoportal04.tabajara.intranet \
	 novoportal05.tabajara.intranet"

ZBXPRX="zbxprx01.tabajara.local"
ZBXSND=$(which zabbix_sender)
AGR="credenciamento"
KEY="PROBE"
FILE="/tmp/falha-probe-cred"

fn_send_zabbix()
        {
        $ZBXSND -z $ZBXPRX -s $AGR -k $KEY -o "$MSG"

        }

for SRV in `echo $SERVERS`
	do
		RESULT=`curl -s --header 'Host: credenciamento.tabajara.com.br' http://$SRV/credenciamento-api/health | grep -w  "UP"`

		if [ `echo $?` != 0 ]
			then
				echo "Falha no probe do credenciamento - Host: $SRV" >> $FILE
		fi

		TTL=`wc -l $FILE | awk '{ print $1 }'`

		if [ $TTL -gt 0 ]
			then
				MSG=`cat $FILE`
				fn_send_zabbix
			else
				MSG="0"
				fn_send_zabbix
		fi
	done

rm $FILE
