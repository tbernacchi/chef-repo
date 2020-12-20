#!/bin/bash
# ############################
# Script facility seek-shell
# @author: Marcelo Tonin
# @initial designer: Ambrosia Araujo
# @email: marcelo.tonin@wal-mart.com
# ############################

# example
# seek-shell.sh --logpath "/u00/app/oracle/diag/tnslsnr/9GXD2V1/listener/trace/listener.log" --bytedb "/tmp/listener.tonin" --lock "/tmp/lock.tonin" --regexp "-B1\ 'TNS-'"
### Variaveis
EGREP=`which egrep`

# Funcoes
help() {
echo -en "
Usage: `basename $0` [arguments] -i <instance> -t <type> -s <subtype>

    -l, --logpath       log path to be read
    -r, --regexp        regexp para o egrep
    -b, --bytedb        bytedb control
    -c, --lock          lock file on running
"
exit 1
}

# Tratamento dos Parametros
for arg
do
    delim=""
    case "$arg" in
    #translate --gnu-long-options to -g (short options)
        --logpath)      args="${args}-l ";;
        --regexp)       args="${args}-r ";;
        --bytedb)       args="${args}-d ";;
        --lock)         args="${args}-c ";;
        --help)         args="${args}-h ";;
       #pass through anything else
       *) [[ "${arg:0:1}" == "-" ]] || delim="\""
           args="${args}${delim}${arg}${delim} ";;
    esac
done

eval set -- $args

while getopts "hl:r:d:c:" PARAMETRO
do
    case $PARAMETRO in
        h) help;;
        l) LOG=${OPTARG[@]};;
        r) REGEXP=${OPTARG[@]};;
        d) BYTEDB=${OPTARG[@]};;
        c) LOCK=${OPTARG[@]};;
        :) echo "Option -$OPTARG requires an argument."; exit 1;;
        *) echo $OPTARG is an unrecognized option ; echo $USAGE; exit 1;;
    esac
done

## Valida/cria LOCK
if [ -f ${LOCK}  ]; then
    exit 1
else
    /bin/touch ${LOCK}
fi

## Valida se o arquivo eh novo
ATUAL=$(ls -l ${LOG} | awk '{print $5}')

## Se nao existe bytedb cria com o tamanho atual
if [ ! -f ${BYTEDB}  ]; then
    echo ${ATUAL} > ${BYTEDB}
    ULTIMO=${ATUAL}
else
        ULTIMO=$(cat ${BYTEDB})
        if [ $ULTIMO -gt $ATUAL ]; then
            echo "0" > $BYTEDB
        fi
fi

## Le o log iniciando no SEEKDB
SEEK=$(cat ${BYTEDB})

##
## Parser aqui

RESULT=`tail -c +${SEEK} ${LOG}`

echo $RESULT | grep  ${REGEXP}

if [ $result == 0  ]
	then
		echo "nao zerado"
	else
		echo "zerado"
fi

## grava o seek
NOVOSEEK=$(echo "${ATUAL}" > ${BYTEDB})

## Remove LOCK
/bin/rm ${LOCK}
