name "boostrap"
description "Boostrap nodes"
env_run_lists   "qa"   => ["recipe[bootstrap]"],
                "prod" => ["recipe[bootstrap]", "recipe[bootstrap::zabbix]", "recipe[bootstrap::bacula]"],
                "_default" => []
