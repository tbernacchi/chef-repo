if node.chef_environment == 'prod' 
		default['stl-security']['svcuser'] = "svc_deploy_prod"
		default['stl-security']['rsyslogserver'] = "zion01.tabajara.intranet"
end 
