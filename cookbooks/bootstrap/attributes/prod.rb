if node.chef_environment == 'prod' 
		default['bootstrap']['baseurl'] = "repo.tabajara.intranet"
		default['bootstrap']['zbxserver'] = "zbxprx04.tabajara.intranet" 
end 
