name "stl-ntpserver"
description "Base configuration for ntp-servers"

# Contempla as receitas:
# stl-ntpserver::ntpserver - Configura o ntpserver
# stl-repo::repo - Configura o repo
# stl-conf::conf - Arquivos de conf
# stl-chef-client::chef-client-service - Configura o daemon do chef-client

env_run_lists  "qa" => ["recipe[stl-ntpserver::ntpserver@0.1.0]",
			"recipe[stl-repo::repo@0.1.0]",	
			"recipe[stl-conf::conf@0.1.0]",
			"recipe[stl-chef-client::chef-client-service@0.1.2]"],
                        
               "prod" => ["recipe[stl-ntpserver::ntpserver@0.1.0]",
                	   "recipe[stl-repo::repo@0.1.0]",	
			   "recipe[stl-conf::conf@0.1.0]",
		           "recipe[stl-chef-client::chef-client-service@0.1.2]"],

                "_default" => []
                
