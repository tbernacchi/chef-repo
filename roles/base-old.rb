name "base-old"
description "Old configuration for old servers"

# Contempla as receitas:
# stl-ntp::ntp - Instala e configura o ntp
# stl-repo::repo - Configura os repos
# stl-conf::conf-old - Mantém os arquivos de conf old dos servers legados
# stl-conf::logrotate - Configura o logrotate
# stl-bacula::bacula-client - Instala e configura o client do bacula
# stl-zabbix::zabbix-client - Instala e configura o client do zabbix
# stl-chef-client::chef-client-service - Configura o daemon do chef-client
# stl-zabbix-balancer::zabbix-balancer - Faz o balanceamento do agent do zabbix 
# stl-monit-so-applics::monits-so-applics - Verifica a versao do java com o so.

env_run_lists  "qa" => ["recipe[stl-ntp::ntp@0.1.2]",
                        "recipe[stl-repo::repo@0.1.0]",
                        "recipe[stl-conf::conf@0.1.0]",
			"recipe[stl-install::network-sniffer@0.1.0]",
			"recipe[stl-chef-client::chef-client-service@0.1.2]"],  
			#"recipe[stl-spacewalk::client@0.1.0]"],  
                        
               "prod" => ["recipe[stl-ntp::ntp@0.1.3]",
                        "recipe[stl-repo::repo@0.1.0]",
                        "recipe[stl-conf::conf-old@0.1.0]",
                        "recipe[stl-conf::logrotate@0.1.0]",
                        #"recipe[stl-bacula::bacula-client@0.1.0]",
			"recipe[stl-chef-client::chef-client-service@0.1.2]",
			"recipe[stl-zabbix-balancer::zabbix-balancer@0.1.0]",
			"recipe[stl-monits-so-applics::monits-so-applics@0.1.0]", 
			"recipe[stl-install]"],

                "_default" => []

