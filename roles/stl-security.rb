name "stl-security"
description "Security configurations for Linux Systems"

# Contempla as receitas:
# stl-security::oddjobd - Enable and start on oddjobd.service to create homedir for users
# stl-security::history - Enable timestamp on history
# stl-security::security-to-rsyslog - Send security commands to rsyslog
# stl-security::sudoers-block-commands -  Restrict commands for sudo 

env_run_lists  "qa" => [#"recipe[stl-security::oddjobd@0.1.0]",
			"recipe[stl-security::history@0.1.0]", 
			"recipe[stl-security::history-to-rsyslog@0.1.0]", 
			"recipe[stl-security::sudoers-block-commands@0.1.0]"],
                        
		"prod" => [#"recipe[stl-security::oddjobd@0.1.0]",
			"recipe[stl-security::history@0.1.0]", 
			"recipe[stl-security::history-to-rsyslog@0.1.0]"], 

                "_default" => []
                
