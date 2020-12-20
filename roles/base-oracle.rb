name "base-oracle"
description "Base configuration for Oracle 6.9"

# Contempla as receitas:
# stl-ntp::ntp - Instala e configura o ntp
# stl-chef-client::chef-client-service - Configura o daemon do chef-client
# stl-conf::logrotate - Configura o logrotate

env_run_lists  "qa" => ["recipe[stl-ntp::ntp@0.1.0]",
			"recipe[stl-chef-client::chef-client-service@0.1.0]",
			"recipe[stl-conf::logrotate@0.1.0]"], 
                        
                "prod" => ["recipe[stl-ntp::ntp@0.1.0]",
                        "recipe[stl-chef-client::chef-client-service@0.1.0]",
			"recipe[stl-conf::logrotate@0.1.0]"],

                "_default" => []

