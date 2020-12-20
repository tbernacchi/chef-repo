name "stl-k8s-master-nodes"
description "Kubernetes Master Nodes"
env_run_lists 	"qa" => ["role[base-centos]", "recipe[stl-docker]", "recipe[stl-kubernetes::master_nodes]"],
		            "prod" => ["role[base-centos]", "recipe[stl-docker]", "recipe[stl-kubernetes::master_nodes]"],
		            "_default" => []
