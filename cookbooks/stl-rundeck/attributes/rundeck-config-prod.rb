# confs de banco
default['rundeck']['prod']['rundeck.projectsStorageType'] = 'db'
default['rundeck']['prod']['dataSource.dbCreate'] = 'update'
default['rundeck']['prod']['dataSource.properties.maxActive'] = '200'
default['rundeck']['prod']['dataSource.properties.testOnBorrow'] = 'true'
default['rundeck']['prod']['dataSource.properties.testOnReturn'] = 'true'
default['rundeck']['prod']['dataSource.properties.testWhileIdle'] = 'true'
default['rundeck']['prod']['dataSource.url'] = ' jdbc:mysql://haproxy.tabajara.intranet/rundeck_new?autoReconnect'
default['rundeck']['prod']['dataSource.username'] = 'rundeckuser_new'
default['rundeck']['prod']['dataSource.password'] = 'run3c7u#r'

# msgs
default['rundeck']['prod']['grails.mail.host'] = 'smtp.tabajara.intranet'
default['rundeck']['prod']['grails.mail.password'] = 'kwf4384R?'
default['rundeck']['prod']['grails.mail.port'] = '25'
default['rundeck']['prod']['grails.mail.username'] = 'svc_zabbix_monit'
#default['rundeck']['prod']['grails.serverURL'] = 'http://<%= node['fqdn'] %>:4440'
default['rundeck']['prod']['grails.serverURL'] = 'http://rundeck.tabajara.intranet'

# job format
default['rundeck']['prod']['jobslist.date.format'] = 'd/M/yy h:mm a'

# log
default['rundeck']['prod']['loglevel.default'] = 'DEBUG'

# scheduler quartz
default['rundeck']['prod']['quartz.props.threadPool.threadCount'] = ' 20'

# base dir
default['rundeck']['prod']['rss.enabled'] = 'false'
default['rundeck']['prod']['rundeck.api.tokens.duration.max'] = ' 0'
default['rundeck']['prod']['rundeck.clusterMode.autotakeover.delay'] = ' 60'
default['rundeck']['prod']['rundeck.clusterMode.autotakeover.enabled'] = 'true'
default['rundeck']['prod']['rundeck.clusterMode.autotakeover.policy'] = 'any'
default['rundeck']['prod']['rundeck.clusterMode.autotakeover.sleep'] = ' 300'
default['rundeck']['prod']['rundeck.clusterMode.enabled'] = 'true'
default['rundeck']['prod']['rundeck.clusterMode.heartbeat.considerDead'] = '86400'
default['rundeck']['prod']['rundeck.clusterMode.heartbeat.considerInactive'] = '150'
default['rundeck']['prod']['rundeck.clusterMode.heartbeat.delay'] = '10'
default['rundeck']['prod']['rundeck.clusterMode.heartbeat.interval'] = '30'
default['rundeck']['prod']['rundeck.clusterMode.remoteExec.process.interval'] = '10'
default['rundeck']['prod']['rundeck.clusterMode.remoteExecution.config.allowedTags'] = ' worker,secondary'
default['rundeck']['prod']['rundeck.clusterMode.remoteExecution.config.criteria'] = ' threadRatio,load'
default['rundeck']['prod']['rundeck.clusterMode.remoteExecution.policy'] = ' RoundRobin'
default['rundeck']['prod']['rundeck.execution.finalize.retryDelay'] = '5000'
default['rundeck']['prod']['rundeck.execution.finalize.retryMax'] = '10'
default['rundeck']['prod']['rundeck.execution.logs.localFileStorageEnabled'] = ' true'
default['rundeck']['prod']['rundeck.executionMode'] = ' active'
default['rundeck']['prod']['rundeck.execution.stats.retryDelay'] = '5000'
default['rundeck']['prod']['rundeck.execution.stats.retryMax'] = '3'
default['rundeck']['prod']['rundeck.gui.clusterIdentityInFooter'] = ' true'
default['rundeck']['prod']['rundeck.gui.clusterIdentityInHeader'] = ' true'
default['rundeck']['prod']['rundeck.log4j.config.file'] = ' /etc/rundeck/log4j.properties'


# configuracoes do log4j
default['rundeck']['prod']['log4j.appender.cmd-logger.file'] = '/rundeck-logs/rundeck-core/command.log'
default['rundeck']['prod']['log4j.appender.server-logger.file'] = '/rundeck-logs/rundeck-core/rundeck.log'
default['rundeck']['prod']['log4j.appender.audit.file'] = '/rundeck-logs/rundeck-core/rundeck.audit.log'
default['rundeck']['prod']['log4j.appender.options.file'] = '/rundeck-logs/rundeck-core/rundeck.options.log'
default['rundeck']['prod']['log4j.appender.storage.file'] = '/rundeck-logs/rundeck-core/rundeck.storage.log'
default['rundeck']['prod']['log4j.appender.jobchanges.file'] = '/rundeck-logs/rundeck-core/rundeck.jobs.log'
default['rundeck']['prod']['log4j.appender.execevents.file'] = '/rundeck-logs/rundeck-core/rundeck.executions.log'
default['rundeck']['prod']['log4j.appender.apirequests.file'] = '/rundeck-logs/rundeck-core/rundeck.api.log'
default['rundeck']['prod']['log4j.appender.access.file'] = '/rundeck-logs/rundeck-core/rundeck.access.log'

# projects
default['rundeck']['prod']['project.dir'] = '/var/rundeck/projects'
default['rundeck']['prod']['project.plugin.Notification.SlackNotification.webhook_url'] = 'https://hooks.slack.com/services/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'

# keys
default['rundeck']['prod']['framework.ssh-password-storage-path'] = '/var/lib/rundeck/var/storage/content/keys'

# frameworklogs
default['rundeck']['prod']['framework.logs.dir'] = '/rundeck-logs/rundeck-framework'
default['rundeck']['prod']['framework.logs.dir'] = '/rundeck-logs-json'
default['rundeck']['prod']['rdeck.base'] = '/var/lib/rundeck'
default['rundeck']['prod']['framework.var.dir'] = '/var/lib/rundeck/var'
default['rundeck']['prod']['framework.tmp.dir'] = '/var/lib/rundeck/var/tmp'
default['rundeck']['prod']['framework.libext.dir'] = '/var/lib/rundeck/libext'
default['rundeck']['prod']['framework.ssh.keypath'] = '/var/lib/rundeck/.ssh/id_rsa'

default['rundeck']['prod']['framework.plugin.Notification.SlackNotification.webhook_url'] = 'https://hooks.slack.com/services/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'
default['rundeck']['prod']['framework.server.name'] = '<%= node[fqdn] %>'
default['rundeck']['prod']['framework.server.hostname'] = '<%= node[fqdn] %>'
default['rundeck']['prod']['framework.server.port'] = '4440'
#default['rundeck']['prod']['framework.server.url'] = 'http://<%= node[fqdn] %>'
default['rundeck']['prod']['framework.server.url'] = 'http://rundeck.tabajara.intranet'

default['rundeck']['prod']['framework.ssh.user'] = 'root'
default['rundeck']['prod']['framework.ssh-password-storage-path'] = '/var/lib/rundeck/var/storage/content/keys'

# auth AD
default['rundeck']['prod']['debug'] = 'true'
default['rundeck']['prod']['providerUrl'] = 'ldap://tabajaradc.local:3268'
default['rundeck']['prod']['bindDn'] = 'CN=svc_rundeck2,OU=Services,OU=TABAJARA,DC=tabajaradc,DC=local'
default['rundeck']['prod']['bindPassword'] = 'runDec2018'
default['rundeck']['prod']['authenticationMethod'] = 'simple'
default['rundeck']['prod']['forceBindingLogin'] = 'true'
default['rundeck']['prod']['userBaseDn'] = 'DC=tabajaradc,DC=local'
default['rundeck']['prod']['userRdnAttribute'] = 'sAMAccountName'
default['rundeck']['prod']['userIdAttribute'] = 'sAMAccountName'
default['rundeck']['prod']['userPasswordAttribute'] = 'unicodePwd'
default['rundeck']['prod']['userObjectClass'] = 'user'
default['rundeck']['prod']['roleBaseDn'] = 'DC=tabajaradc,DC=local'
default['rundeck']['prod']['roleNameAttribute'] = 'cn'
default['rundeck']['prod']['roleMemberAttribute'] = 'member'
default['rundeck']['prod']['roleObjectClass'] = 'group'
default['rundeck']['prod']['cacheDurationMillis'] = '300000'

# NGINX
default['rundeck']['nginx']['prod']['app_name'] = 'rundeck'
default['rundeck']['nginx']['prod']['app_port'] = '4440'
default['rundeck']['nginx']['prod']['server_name'] = 'rundeck.tabajara.intranet'

# Para trabalhar em cluster se necessario, adicionar no self, id no server (UUID)
if node['fqdn'] == 'zonzo04.tabajara.intranet'
#  default['rundeck']['prod']['rundeck.clusterMode.remoteExecution.config.allowed'] = 'self,614fecde-057e-4966-8790-2255bee89d44'
  default['rundeck']['prod']['rundeck.clusterMode.remoteExecution.config.allowed'] = 'self'
end

if node['fqdn'] == 'zonzo05.tabajara.intranet'
  default['rundeck']['prod']['rundeck.clusterMode.remoteExecution.config.allowed'] = 'self,614fecde-057e-4966-8790-2255bee89d44'
end




