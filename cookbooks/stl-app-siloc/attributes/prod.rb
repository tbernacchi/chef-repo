## Web Portal
default['siloc']['applications']['prod']['version'] = ''
# application Versions
default['siloc']['package_name'] = ''
default['siloc']['package_version'] = ''

# Nginx
default['siloc']['nginx']['prod']['version']      = '1.13.10-1.el7_4.ngx'
default['siloc']['nginx']['prod']['package_name'] = 'nginx'
default['siloc']['nginx']['prod']['listen_port'] = '80'
default['siloc']['nginx']['prod']['app_port'] = '8081'
default['siloc']['nginx']['prod']['app_name'] = 'silocweb'
default['siloc']['nginx']['prod']['server_name'] = 'siloc.tabajara.intranet'

# APP webportal
default['siloc']['webportal']['prod']['log_path'] = '/opt/siloc/web/siloc-web-portal/logs/siloc-web-portal.log'
default['siloc']['webportal']['prod']['app_port'] = '8081'
default['siloc']['webportal']['prod']['dir_saida'] = '/opt/silocarquivos/cip/saida/reprocessado/'
default['siloc']['webportal']['prod']['dir_entrada'] = '/opt/silocarquivos/cip/saida/'

## Entrada CIP
default['siloc']['en_cip']['prod']['log_path'] = '/opt/siloc/entrada/siloc-entrada-cip-job/logs/siloc-entrada-cip-job.log'
default['siloc']['en_cip']['prod']['app_port'] = '8024'
default['siloc']['en_cip']['prod']['privateKey'] = '/opt/silocarquivos/siloc/jks/tabajara_prd_2019.jks'
default['siloc']['en_cip']['prod']['publicKey'] = '/opt/silocarquivos/siloc/jks/tabajara_prd_2019.jks'
default['siloc']['en_cip']['prod']['cip_dir'] = 'file:/opt/silocarquivos/cip/entrada?move=processed&moveFailed=error&readLock=changed&readLockCheckInterval=5000&readLockTimeout=10m&sortBy=file:modified;file:onlyname'
default['siloc']['en_cip']['prod']['cip_publicKey'] = '/opt/silocarquivos/siloc/jks/cip.jks'
default['siloc']['en_cip']['prod']['proc_dir'] = '/opt/silocarquivos/cip/entrada/'
default['siloc']['en_cip']['prod']['proc_log_hexa'] = '/opt/silocarquivos/siloc/interno/cip/log/hexa/'
default['siloc']['en_cip']['prod']['proc_log_xml'] = '/opt/silocarquivos/siloc/interno/cip/log/xml/'

## Entrada tabajara
default['siloc']['en_tabajara']['prod']['log_path'] = '/opt/siloc/entrada/siloc-entrada-tabajara-job/logs/siloc-entrada-tabajara-job.log'
default['siloc']['en_tabajara']['prod']['app_port'] = '8023'
default['siloc']['en_tabajara']['prod']['ent_dir'] = '/opt/silocarquivos/payware/entrada'
default['siloc']['en_tabajara']['prod']['ordem_pgto'] = '02,04,23,31'
## INFRA-1002
default['siloc']['en_tabajara']['prod']['ent_cre'] = '/opt/silocarquivos/payware/entrada/credito'
default['siloc']['en_tabajara']['prod']['ent_cre_err'] = '/opt/silocarquivos/payware/entrada/credito/error'

## INFRA-1002
default['siloc']['en_tabajara']['prod']['cron_cre'] = '10 0/10 6-18 1/1 * ?'
default['siloc']['en_tabajara']['prod']['hab_cron'] = 'true'

## Saida CIP
default['siloc']['sa_cip']['prod']['log_path'] = '/opt/siloc/saida/siloc-saida-cip-job/logs/siloc-saida-cip-job.log'
default['siloc']['sa_cip']['prod']['app_port'] = '8021'
default['siloc']['sa_cip']['prod']['ent_dir'] = '/opt/silocarquivos/siloc/interno/cip/'
default['siloc']['sa_cip']['prod']['saida_dir'] = '/opt/silocarquivos/cip/saida/'
default['siloc']['sa_cip']['prod']['log_dir'] = '/opt/silocarquivos/siloc/interno/cip/saida/log'

## Saida tabajara
default['siloc']['sa_tabajara']['prod']['log_path'] = '/opt/siloc/saida/siloc-saida-tabajara-job/logs/siloc-saida-tabajara-job.log'
default['siloc']['sa_tabajara']['prod']['app_port'] = '8020'
default['siloc']['sa_tabajara']['prod']['ent_dir'] = '/opt/silocarquivos/siloc/interno/tabajara/'
default['siloc']['sa_tabajara']['prod']['saida_dir'] = '/opt/silocarquivos/payware/saida/'
default['siloc']['sa_tabajara']['prod']['log_dir'] = '/opt/silocarquivos/siloc/interno/tabajara/saida/log'

## Processamento XML
default['siloc']['proc_xml']['prod']['log_path'] = '/opt/siloc/processamento/siloc-processamento-geracaoxml-job/logs/siloc-processamento-geracaoxml-job.log'
default['siloc']['proc_xml']['prod']['app_port'] = '8022'
default['siloc']['proc_xml']['prod']['tabajara_privateKey'] = '/opt/silocarquivos/siloc/jks/tabajara_prd_2019.jks'
default['siloc']['proc_xml']['prod']['tabajara_crt_alias'] = 'slc-p006'
default['siloc']['proc_xml']['prod']['tabajara_publicKey'] = '/opt/silocarquivos/siloc/jks/tabajara_prd_2019.jks'
default['siloc']['proc_xml']['prod']['cip_publicKey'] = '/opt/silocarquivos/siloc/jks/cip.jks'
default['siloc']['proc_xml']['prod']['cip_crt_alias'] = 'cip-p002'
default['siloc']['proc_xml']['prod']['cip_bin_dir'] = '/opt/silocarquivos/siloc/interno/cip/'
default['siloc']['proc_xml']['prod']['cip_xml_dir'] = '/opt/silocarquivos/siloc/interno/xml/'
default['siloc']['proc_xml']['prod']['cip_hexa_dir'] = '/opt/silocarquivos/siloc/interno/loghexa/'

## credenciamento
default['siloc']['credenciamento']['prod']['log_path'] = '/opt/siloc/entrada/siloc-entrada-credenciamento-job/logs/siloc-entrada-credenciamento-job.log'
default['siloc']['credenciamento']['prod']['app_port'] = '8026'
default['siloc']['credenciamento']['prod']['dir_create'] = '/opt/silocarquivos/credenciamento/'
default['siloc']['credenciamento']['prod']['dir_processed'] = '/opt/silocarquivos/credenciamento/processed/'
default['siloc']['credenciamento']['prod']['dir_payware'] = '/opt/silocarquivos/payware/entrada/'
default['siloc']['credenciamento']['prod']['crontab'] = '0 0/2 1-7 1/1 * ?'
default['siloc']['credenciamento']['prod']['cron'] = '0 0 23 * * ?'
#INFRA-1019
default['siloc']['credenciamento']['prod']['crd_entrada'] = '/opt/silocarquivos/credenciamento/entrada/'

#INFRA-1019
default['siloc']['credenciamento']['prod']['crd_saida'] = '/opt/silocarquivos/credenciamento/saida/'
default['siloc']['credenciamento']['prod']['crd_processed'] = '/opt/silocarquivos/credenciamento/saida/processed'
default['siloc']['credenciamento']['prod']['crd_connect'] = '/opt/silocarquivos/credenciamento/saida/connect'

## conciliacao
default['siloc']['conciliacao']['prod']['log_path'] = '/opt/siloc/entrada/siloc-entrada-conciliacao-job/logs/siloc-entrada-conciliacao-job.log'
default['siloc']['conciliacao']['prod']['app_port'] = '8098'
default['siloc']['conciliacao']['prod']['dir_entrada'] = '/opt/silocarquivos/conciliacao/entrada'

## Database
default['siloc']['database']['prod']['host'] = 'bunkyo01.tabajara.intranet'
#default['siloc']['database']['prod']['host'] = 'butanclan01.tabajara.intranet'
default['siloc']['database']['prod']['port'] = '1521'
#default['siloc']['database']['prod']['db_name'] = 'PRDSLOC'
default['siloc']['database']['prod']['db_name'] = 'STBSLOC'
default['siloc']['database']['prod']['user'] = 'USR_SLOC'
default['siloc']['database']['prod']['pass'] = 's0Lc#ciP'
default['siloc']['database']['prod']['max_ative'] = '5'

##
default['rabbitmq']['prod']['host'] = 'zila01.tabajara.intranet'
default['rabbitmq']['prod']['port'] = '5672'
default['rabbitmq']['prod']['user'] = 'guest'
default['rabbitmq']['prod']['vhost'] = '/'

## ldap
default['siloc']['ldap']['prod']['groupsearchbase'] = 'OU=SILOC,OU=Acesso_Sistemas,OU=Grupos,DC=tabajara,DC=corp'
