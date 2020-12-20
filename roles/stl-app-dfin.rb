name "stl-app-dfin"
description "Dfin app role"
run_list "recipe[stl-app-dfin]"
env_run_lists 	"qa" => ["recipe[stl-app-dfin::default]"],
		"prod" => ["role[base-centos]", "recipe[stl-app-dfin@0.1.13]"],
		"_default" => []
