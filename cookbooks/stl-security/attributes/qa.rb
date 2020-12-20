if node.chef_environment == 'qa' 
		default['stl-security']['svcuser'] = "svc_deploy_qa"
		default['stl-security']['rsyslogserver'] = "hzagueiro01.qa.tabajara.intranet"
end 
