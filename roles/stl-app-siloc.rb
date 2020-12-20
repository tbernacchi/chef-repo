name "stl-app-siloc"
description "Siloc app role"
run_list "recipe[stl-app-siloc]"
env_run_lists 	"qa" => ["role[base-centos]", "recipe[stl-app-siloc::default]"],
		"prod" => ["role[base-centos]", "role[stl-security]", "recipe[stl-app-siloc::default@1.0.19]"],
		"_default" => []
