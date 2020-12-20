## Web Portal
default['siloc']['applications']['qa']['version'] = '3.0.25'
default['siloc']['hostname'] = node['fqdn']

default['siloc']['package_name'] = ''
default['siloc']['package_version'] = ''

# Nginx
default['siloc']['nginx']['qa']['version']      = '1.13.10-1.el7_4.ngx'
default['siloc']['nginx']['qa']['package_name'] = 'nginx'
default['siloc']['nginx']['qa']['listen_port'] = '80'
default['siloc']['nginx']['qa']['app_port'] = '8081'
default['siloc']['nginx']['qa']['app_name'] = 'silocweb'
default['siloc']['nginx']['qa']['server_name'] = 'siloc.qa.tabajara.intranet'

# APP
default['siloc']['webportal']['qa']['log_path'] = '/opt/siloc/web/siloc-web-portal/logs/siloc-web-portal.log'
default['siloc']['webportal']['qa']['app_port'] = '8081'
default['siloc']['webportal']['qa']['dir_saida'] = '/opt/silocarquivos/cip/saida/reprocessado/'
default['siloc']['webportal']['qa']['dir_entrada'] = '/opt/silocarquivos/cip/saida/'

## Entrada CIP
default['siloc']['en_cip']['qa']['log_path'] = '/opt/siloc/entrada/siloc-entrada-cip-job/logs/siloc-entrada-cip-job.log'
default['siloc']['en_cip']['qa']['app_port'] = '8024'
default['siloc']['en_cip']['qa']['privateKey'] = '/opt/silocarquivos/siloc/jks/tabajara_hml_2019.jks'
default['siloc']['en_cip']['qa']['publicKey'] = '/opt/silocarquivos/siloc/jks/tabajara_hml_2019.jks'
default['siloc']['en_cip']['qa']['cip_dir'] = 'file:/opt/silocarquivos/cip/entrada?move=processed&moveFailed=error&readLock=changed&readLockCheckInterval=5000&readLockTimeout=10m'
default['siloc']['en_cip']['qa']['cip_publicKey'] = '/opt/silocarquivos/siloc/jks/cip.jks'
default['siloc']['en_cip']['qa']['proc_dir'] = '/opt/silocarquivos/cip/entrada/'
default['siloc']['en_cip']['qa']['proc_log_hexa'] = '/opt/silocarquivos/siloc/interno/cip/log/hexa/'
default['siloc']['en_cip']['qa']['proc_log_xml'] = '/opt/silocarquivos/siloc/interno/cip/log/xml/'

## Entrada tabajara
default['siloc']['en_tabajara']['qa']['log_path'] = '/opt/siloc/entrada/siloc-entrada-tabajara-job/logs/siloc-entrada-tabajara-job.log'
default['siloc']['en_tabajara']['qa']['app_port'] = '8023'
default['siloc']['en_tabajara']['qa']['ent_dir'] = '/opt/silocarquivos/payware/entrada'
default['siloc']['en_tabajara']['qa']['ordem_pgto'] = '02,04,23,31'
## INFRA-996
default['siloc']['en_tabajara']['qa']['ent_cre'] = '/opt/silocarquivos/payware/entrada/credito'
default['siloc']['en_tabajara']['qa']['ent_cre_err'] = '/opt/silocarquivos/payware/entrada/credito/error'

## INFRA-996
default['siloc']['en_tabajara']['qa']['cron_cre'] = '10 0/10 6-18 1/1 * ?'
default['siloc']['en_tabajara']['qa']['hab_cron'] = 'true'

## Saida CIP
default['siloc']['sa_cip']['qa']['log_path'] = '/opt/siloc/saida/siloc-saida-cip-job/logs/siloc-saida-cip-job.log'
default['siloc']['sa_cip']['qa']['app_port'] = '8021'
default['siloc']['sa_cip']['qa']['ent_dir'] = '/opt/silocarquivos/siloc/interno/cip/'
default['siloc']['sa_cip']['qa']['saida_dir'] = '/opt/silocarquivos/cip/saida/'
default['siloc']['sa_cip']['qa']['log_dir'] = '/opt/silocarquivos/siloc/interno/cip/saida/log'

## Saida tabajara
default['siloc']['sa_tabajara']['qa']['log_path'] = '/opt/siloc/saida/siloc-saida-tabajara-job/logs/siloc-saida-tabajara-job.log'
default['siloc']['sa_tabajara']['qa']['app_port'] = '8020'
default['siloc']['sa_tabajara']['qa']['ent_dir'] = '/opt/silocarquivos/siloc/interno/tabajara/'
default['siloc']['sa_tabajara']['qa']['saida_dir'] = '/opt/silocarquivos/payware/saida/'
default['siloc']['sa_tabajara']['qa']['log_dir'] = '/opt/silocarquivos/siloc/interno/tabajara/saida/log'

## Processamento XML
default['siloc']['proc_xml']['qa']['log_path'] = '/opt/siloc/processamento/siloc-processamento-geracaoxml-job/logs/siloc-processamento-geracaoxml-job.log'
default['siloc']['proc_xml']['qa']['app_port'] = '8022'
default['siloc']['proc_xml']['qa']['tabajara_privateKey'] = '/opt/silocarquivos/siloc/jks/tabajara_hml_2019.jks'
default['siloc']['proc_xml']['qa']['tabajara_crt_alias'] = 'slc-t006'
default['siloc']['proc_xml']['qa']['tabajara_publicKey'] = '/opt/silocarquivos/siloc/jks/tabajara_hml_2019.jks'
default['siloc']['proc_xml']['qa']['cip_publicKey'] = '/opt/silocarquivos/siloc/jks/cip.jks'
default['siloc']['proc_xml']['qa']['cip_crt_alias'] = 'cippublic'
default['siloc']['proc_xml']['qa']['cip_bin_dir'] = '/opt/silocarquivos/siloc/interno/cip/'
default['siloc']['proc_xml']['qa']['cip_xml_dir'] = '/opt/silocarquivos/siloc/interno/xml/'
default['siloc']['proc_xml']['qa']['cip_hexa_dir'] = '/opt/silocarquivos/siloc/interno/loghexa/'

## credenciamento
default['siloc']['credenciamento']['qa']['log_path'] = '/opt/siloc/entrada/siloc-entrada-credenciamento-job/logs/siloc-entrada-credenciamento-job.log'
default['siloc']['credenciamento']['qa']['app_port'] = '8026'
default['siloc']['credenciamento']['qa']['dir_create'] = '/opt/silocarquivos/credenciamento/'
default['siloc']['credenciamento']['qa']['dir_processed'] = '/opt/silocarquivos/credenciamento/processed/'
default['siloc']['credenciamento']['qa']['dir_payware'] = '/opt/silocarquivos/payware/entrada/'
default['siloc']['credenciamento']['qa']['crontab'] = '0 0/2 * 1/1 * ?'
default['siloc']['credenciamento']['qa']['cron'] = '0 0/5 * * * ?'

## conciliacao
default['siloc']['conciliacao']['qa']['log_path'] = '/opt/siloc/entrada/siloc-entrada-conciliacao-job/logs/siloc-entrada-conciliacao-job.log'
default['siloc']['conciliacao']['qa']['app_port'] = '8098'
default['siloc']['conciliacao']['qa']['dir_entrada'] = '/opt/silocarquivos/conciliacao/entrada'

## Database
default['siloc']['database']['qa']['host'] = 'hbutanclan01.qa.tabajara.intranet'
default['siloc']['database']['qa']['port'] = '1521'
default['siloc']['database']['qa']['db_name'] = 'HMLSLOC'
default['siloc']['database']['qa']['user'] = 'USR_SLOC'
default['siloc']['database']['qa']['pass'] = 'sloc#l0c'
default['siloc']['database']['qa']['max_ative'] = '5'

default['rabbitmq']['qa']['host'] = 'hzila01.qa.tabajara.intranet'
default['rabbitmq']['qa']['port'] = '5672'

## ldap
default['siloc']['ldap']['qa']['usersearchfilter'] = '(sAMAccountName={0})'
default['siloc']['ldap']['qa']['usersearchbase'] = 'DC=tabajara,DC=corp'
default['siloc']['ldap']['qa']['groupsearchbase'] = 'OU=SILOC,OU=Acesso_Sistemas,OU=Grupos,DC=tabajara,DC=corp'
default['siloc']['ldap']['qa']['url'] = 'ldap://horpwv01aste.tabajara.corp'
default['siloc']['ldap']['qa']['port'] = '3268'
default['siloc']['ldap']['qa']['dn'] = 'CN=svc_portal,OU=Services,OU=TABAJARA,DC=tabajara,DC=corp'
default['siloc']['ldap']['qa']['password'] = 'cesar@123'
default['siloc']['ldap']['qa']['enabled'] = 'true'
