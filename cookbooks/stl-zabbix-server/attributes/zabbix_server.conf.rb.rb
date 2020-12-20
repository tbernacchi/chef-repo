default['zbxserver']['conf']['logfile']['path'] = '/var/log/zabbix/zabbix_server.log'

default['zbxserver']['conf']['logfile']['size'] = '0'

default['zbxserver']['conf']['pid'] = '/var/run/zabbix/zabbix_server.pid'

default['zbxserver']['conf']['db']['host'] = 'dbmysql.tabajara.intranet'

default['zbxserver']['conf']['db']['name'] = 'zabbixdb'

default['zbxserver']['conf']['db']['user'] = 'zabbixuser'

default['zbxserver']['conf']['db']['pass'] = 'Mudar@123'

default['zbxserver']['conf']['timeout'] = '4'

default['zbxserver']['conf']['logslowqueries'] = '3000'

default['zbxserver']['conf']['cache']['size'] = '2G'

default['zbxserver']['conf']['cache']['history'] = '512M'

default['zbxserver']['conf']['cache']['value'] = '400M'

default['zbxserver']['conf']['start']['pingers'] = '100'

default['zbxserver']['conf']['start']['discoveres'] = '50'

default['zbxserver']['conf']['start']['pollersunreac'] = '20'

default['zbxserver']['conf']['debug']['level'] = '20'
