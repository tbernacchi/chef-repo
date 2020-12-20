name "base-centos"
description "Base configuration for CentOS"

# Contempla as receitas:
# stl-ntp::ntp - Instala e configura o ntp
# stl-repo::repo - Configura os repos
# stl-conf::conf - Mantém os arquivos de conf
# stl-bacula::bacula-client - Instala e configura o client do bacula
# stl-zabbix::zabbix-client - Instala e configura o client do zabbix
# stl-chef-client::chef-client-service - Configura o daemon do chef-client

env_run_lists  "lab" => ["recipe[stl-ntp::ntp@0.1.3]",
			                  "recipe[stl-ntp::horario-verao@0.1.3]",
                        "recipe[stl-repo::repo@0.1.1]",
                        "recipe[stl-conf::conf@0.1.0]",
			                  "recipe[stl-install::network-sniffer@0.1.0]",
			                  "recipe[stl-chef-client::chef-client-service@0.1.2]",
                        "recipe[stl-rundeck::rundeck-deploy-app]"],
			                  #"recipe[stl-spacewalk::client@0.1.0]"],  
               
               "qa" => ["recipe[stl-repo::repo@0.1.1]",
                        "recipe[stl-ntp::ntp@0.1.3]",
			                  "recipe[stl-ntp::horario-verao@0.1.3]",
                        "recipe[stl-conf::conf@0.1.0]",
			                  "recipe[stl-install::network-sniffer@0.1.0]",
			                  "recipe[stl-chef-client::chef-client-service@0.1.2]",
                        "recipe[stl-rundeck::rundeck-deploy-app]"],
			                  #"recipe[stl-spacewalk::client@0.1.0]"],  

               "prod" => ["recipe[stl-repo::repo@0.1.1]",
			                  "recipe[stl-ntp::horario-verao@0.1.3]",
                        "recipe[stl-conf::conf@0.1.0]",
                        "recipe[stl-conf::sudoers@0.1.0]",
                        "recipe[stl-bacula::bacula-client@0.1.0]",
			                  "recipe[stl-chef-client::chef-client-service@0.1.2]",
			                  "recipe[stl-zabbix-balancer::zabbix-balancer@0.1.0]",
                        #"recipe[stl-rundeck::rundeck-deploy-app]",
                        "recipe[stl-security::history@0.1.0]",
                        "recipe[stl-security::history-to-rsyslog@0.1.0]",
			                  "recipe[stl-monits-so-applics::monits-so-applics@0.1.0]", 
			                  "recipe[stl-install@0.1.0]"],

                "_default" => []

