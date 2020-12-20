#!/bin/sh

# Script para monitorar se o arquivo de EDI do Finnet usado no Matera
# Foi salvo no share final no servidor windows para upload dentro do
# Matera
# Autor: Ambrosia Ambrosiano
# mail: ambrosia.ambrosiano@tabajara.com.br / ambrosia@gmail.com
# 16/05/2019

ANOFULL=`date +%Y`
ANOSHORT=`date +%y`
DIA=`date +%d`
MES=`date +%m`

# FILE
FILE="EDI4693847_1813897$DIA$MES$ANOSHORT"

fn_send_zabbix()
  {
   /usr/bin/zabbix_sender -z zbxprxapp01.tabajara.intranet -s matera -k FINNET_MATERA -o "$MSG"
  }

fn_check_file()
  {
  # List

  SEG=`date +%u`

  if [ $SEG == 1 ]
    then
      echo "eh segunda, verificamos o arquivo anterior"
      DOM=`date +%d --date="2 days ago"`
      FILE="EDI4693847_1813897$DOM$MES$ANOSHORT"

      sshpass -p 's2H&ltal' ssh svc_transfer_file@infrajobs02.tabajara.intranet 'c:/arquivo_matera/script/list-fl-saida.bat' | grep $FILE > /dev/null
      RESULT=`echo $?`

      HR=`date +%H`

      if [ $HR -lt 02 ]
        then
          MSG="0"
          fn_send_zabbix
  
      elif [ $RESULT != 0 ]
        then
        MSG="Possivel problema com EDI do FINNET do Matera"
        fn_send_zabbix
        else
          MSG="0"
          fn_send_zabbix
      fi
  fi
  
  }

  fn_check_file
