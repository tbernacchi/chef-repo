name "stl-siloc-vintws"
description "Role para o servidor vintws com os scripts do siloc"
run_list "recipe[stl-app-siloc]"
env_run_lists 	"qa" => ["role[base-centos]", "recipe[stl-app-siloc::default]"],
		"prod" => ["role[base-old]", "role[stl-security]", "recipe[stl-app-siloc::vintws@1.0.15]"],
		"_default" => []
