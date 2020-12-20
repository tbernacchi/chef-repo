name "stl-rancher"
description "Rancher role"
run_list "recipe[stl-rancher]"
env_run_lists 	"qa" => ["role[base-centos]", "recipe[stl-rancher::nodes]"],
		"prod" => ["role[base-centos]", "recipe[stl-chef-client]", "recipe[stl-repo::docker]", "recipe[stl-rancher::nodes]"],
		"_default" => []
