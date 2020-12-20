name "stl-k8s-master"
description "Kubernetes Master"
env_run_lists 	"qa" => ["role[base-centos]", "recipe[stl-docker]", "recipe[stl-kubernetes::master]"],
		            "prod" => ["role[base-centos]"],
		            "_default" => []
