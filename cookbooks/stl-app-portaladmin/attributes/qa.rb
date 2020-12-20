## DATABASES
# CDTO
default['portaladm']['qa']['datasource']['cdto']['server-name'] = 'hbutanclan01.qa.tabajara.intranet'
default['portaladm']['qa']['datasource']['cdto']['db_name'] = 'HMLCDTO'
default['portaladm']['qa']['datasource']['cdto']['url'] = 'jdbc:oracle:thin:@hbutanclan01.qa.tabajara.intranet:1521:HMLCDTO'
default['portaladm']['qa']['datasource']['cdto']['username'] = 'usr_portal_admin'
default['portaladm']['qa']['datasource']['cdto']['password'] = 'sUZ7SYEldaZcwxWfmx8XiqrykxLtXM+Agz9bLPqbAOg='

# TRNG
default['portaladm']['qa']['datasource']['trng']['server-name'] = 'hbutanclan01.qa.tabajara.intranet'
default['portaladm']['qa']['datasource']['trng']['db_name'] = 'HMLTRNG'
default['portaladm']['qa']['datasource']['trng']['url'] = 'jdbc:oracle:thin:@hbutanclan01.qa.tabajara.intranet:1521:HMLTRNG'
default['portaladm']['qa']['datasource']['trng']['username'] = 'usr_portal_admin'
default['portaladm']['qa']['datasource']['trng']['password'] = 'sUZ7SYEldaZcwxWfmx8XiqrykxLtXM+Agz9bLPqbAOg='

# OAUTH
default['portaladm']['qa']['oauth']['url'] = 'http://portalvendedor.hml1.tabajara.local/api'

# OUD
default['portaladm']['qa']['oud']['url'] = 'ldap://oud.hml1.tabajara.local:1389'
default['portaladm']['qa']['oud']['sec_auth'] = 'simple'
default['portaladm']['qa']['oud']['sec_principal'] = 'cn=serv_portal,ou=Applications,ou=Users,o=tabajara,dc=tabajara,dc=com,dc=br'
default['portaladm']['qa']['oud']['search_base'] = 'ou=PeopleV2,ou=Customers,o=tabajara,dc=tabajara,dc=com,dc=br'
default['portaladm']['qa']['oud']['sec_credentials'] = 'Welcome1'
default['portaladm']['qa']['oud']['init_context_factory'] = 'com.sun.jndi.ldap.LdapCtxFactory'

# Cadu CADU_INTEGRATION / OSB
default['portaladm']['qa']['osb']['url'] = 'http://osb.hml1.tabajara.local/cadu/PreCadastroMPOS/v1?wsdl'
default['portaladm']['qa']['osb']['adq_credenciamento'] = 'http://osb.hml1.tabajara.local/adquirencia/credenciamento/v2?wsdl'
default['portaladm']['qa']['osb']['trans_pedidos'] = 'http://osb.hml1.tabajara.local:80/workflow/transacoes/pedidos/v2?wsdl'

# Active Directory
default['portaladm']['qa']['ad']['base'] = 'OU=Users,OU=TABAJARA,DC=tabajara,DC=corp'
default['portaladm']['qa']['ad']['url'] = 'ldap://horpwv01aste.tabajara.corp:3268/'
default['portaladm']['qa']['ad']['user'] = 'CN=svc_portal,OU=Services,OU=TABAJARA,DC=tabajara,DC=corp'
default['portaladm']['qa']['ad']['password'] = 'cesar@123'

# mandrill
default['portaladm']['qa']['mandril']['url'] = 'https://mandrillapp.com/api/1.0/messages/send-template'
default['portaladm']['qa']['mandril']['tkn_template'] = 'http://portalvendedor.hml1.tabajara.local/auth/nova-senha?token=:token&cn=:cn'
default['portaladm']['qa']['mandril']['pre_chgBack_url'] = 'https://mandrillapp.com/api/1.0/messages/send-template.json'
default['portaladm']['qa']['mandril']['pre_chgBack_key'] = 'lWklkoFqZIuKt_0ingO4kw'
default['portaladm']['qa']['mandril']['ajuste_credito_key'] = 'WOBMv2xR5Ee7DbsFmEJ9ug'


# CAPTCHA
default['portaladm']['qa']['captcha_keyID'] = '491e283f232c'
default['portaladm']['qa']['captcha_userID'] = '535861013'

# Proxy
default['portaladm']['qa']['proxy_host'] = 'proxy.qa.tabajara.intranet'
default['portaladm']['qa']['proxy_port'] = '3130'

# Zenvia
default['portaladm']['qa']['zenvia_password'] = 'x4BhHioMnZ'
default['portaladm']['qa']['zenvia_user'] = 'tabajara.connect'
default['portaladm']['qa']['zenvia_url'] = 'http.zenvia.com'
default['portaladm']['qa']['zenvia_path'] = '/GatewayIntegration/msgSms.do'
default['portaladm']['qa']['zenvia_port'] = '80'

# PAX
default['portaladm']['qa']['pax']['url'] = 'https://sales.basissolution.com.br/WSSALES/VENDASPAX.svc'
default['portaladm']['qa']['pax']['identificacao'] = 'TABAJARA'
default['portaladm']['qa']['pax']['credencial'] = '@2017TABAJARAPROD!'
default['portaladm']['qa']['pax']['senha'] = '50327102SEAVONORASSAP'

# DXC
default['portaladm']['qa']['dxc']['url'] = '=http://wshp09a.hml1.tabajara.local/CMS-STD-WEB-SERVICES-ACQUIRER/EDSws?wsdl'
default['portaladm']['qa']['dxc']['merchant_url'] = 'http://10.150.226.152:7121/street/pagamentos/agenda'
default['portaladm']['qa']['dxc']['merchant_agrrement_url'] = 'http://wshp09a.hml1.tabajara.local/CMS-STD-WEB-SERVICES-ACQUIRER/OperationControlws?wsdl'
default['portaladm']['qa']['dxc']['merchant_accreditation_url'] = 'http://wshp09a.hml1.tabajara.local/CMS-STD-WEB-SERVICES-ACQUIRER/merchantOperationService?wsdl'
default['portaladm']['qa']['dxc']['merchant_data_url'] = 'http://wshp09a.hml1.tabajara.local/CMS-STD-WEB-SERVICES-ACQUIRER/EDSws?wsdl'
default['portaladm']['qa']['dxc']['merchant_username'] = 'PORTTABAJARA'
default['portaladm']['qa']['dxc']['merchant_password'] = '1::f5433227a0372628ea506743082e52a68c32c306ae548ab82d201bf3f21d2efb'
default['portaladm']['qa']['dxc']['targetDirectory'] = '/app/arquivos/'

# person
default['portaladm']['qa']['person']['app_name'] = 'tabajara-admin-street-person-service-api'
default['portaladm']['qa']['person']['port'] = '7116'
default['portaladm']['qa']['person']['contextPath'] = '/'
default['portaladm']['qa']['person']['jvm_xms'] = '-Xms512m'
default['portaladm']['qa']['person']['jvm_xmx'] = '-Xmx512m'

# authorization
default['portaladm']['qa']['authorization']['app_name'] = 'tabajara-admin-street-authorization-service-api'
default['portaladm']['qa']['authorization']['port'] = '7113'
default['portaladm']['qa']['authorization']['contextPath'] = '/'

# maquina cartao
default['portaladm']['qa']['mcartao']['app_name'] = 'tabajara-admin-street-person-service-api'
default['portaladm']['qa']['mcartao']['port'] = '7117'
default['portaladm']['qa']['mcartao']['contextPath'] = '/'

# orders
default['portaladm']['qa']['orders']['app_name'] = 'tabajara-admin-street-orders-service-api'
default['portaladm']['qa']['orders']['port'] = '7118'
default['portaladm']['qa']['orders']['contextPath'] = '/'

# chargeback
default['portaladm']['qa']['chargeback']['app_name'] = 'tabajara-admin-street-chargeback-service-api'
default['portaladm']['qa']['chargeback']['port'] = '7112'
default['portaladm']['qa']['chargeback']['contextPath'] = '/'
default['portaladm']['qa']['chargeback']['inbox_dir'] = '/app/standalone/portaladmin/chargeback/inbox'
default['portaladm']['qa']['chargeback']['outbox_dir'] = '/app/standalone/portaladmin/chargeback/outbox'

# fees
default['portaladm']['qa']['fees']['app_name'] = 'tabajara-admin-street-fees-service-api'
default['portaladm']['qa']['fees']['port'] = '7119'
default['portaladm']['qa']['fees']['contextPath'] = '/'

# transaction
default['portaladm']['qa']['transaction']['app_name'] = 'tabajara-admin-street-transaction-service-api'
default['portaladm']['qa']['transaction']['port'] = '7120'
default['portaladm']['qa']['transaction']['contextPath'] = '/'

# logistics
default['portaladm']['qa']['logistics']['app_name'] = 'tabajara-admin-street-person-service-api'
default['portaladm']['qa']['logistics']['port'] = '7122'
default['portaladm']['qa']['logistics']['contextPath'] = '/'

# dxc merchant
default['portaladm']['qa']['dmerchant']['app_name'] = 'tabajara-admin-street-authorization-service-api'
default['portaladm']['qa']['dmerchant']['port'] = '7121'
default['portaladm']['qa']['dmerchant']['contextPath'] = '/'

# Config server
default['portaladm']['qa']['git']['repository'] = 'git@git.tabajara.local:sources/channels/portal-admin/configserver.git'
default['portaladm']['qa']['git']['branch'] = 'master'
