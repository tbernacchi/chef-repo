name "stl-k8s-workers"
description "Kubernetes Workers Nodes"
env_run_lists 	"qa" => ["role[base-centos]", "recipe[stl-docker]", "recipe[stl-kubernetes::worker_nodes]"],
		            "prod" => ["role[base-centos]"],
		            "_default" => []
