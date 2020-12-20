if node.chef_environment == 'lab' 
    default['bootstrap']['baseurl'] = "repo.qa.tabajara.intranet"
		default['bootstrap']['zbxserver'] = "zbxprx04.tabajara.intranet" 
end 
