if node.chef_environment == 'prod' 
		default['stl-conf']['svcuser'] = "svc_deploy_prod"
end 
