name "stl-nginx"
description "Nginx role"
run_list "recipe[stl-nginx]"
env_run_lists 	"qa" => ["recipe[stl-nginx::nginx]"],
	 	"prod" => ["recipe[stl-nginx::nginx@0.1.0]"],
		"_default" => []

