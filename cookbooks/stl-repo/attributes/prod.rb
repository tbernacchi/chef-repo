if node.chef_environment == 'prod' 
		default['stl-repo']['baseurl'] = "repo.tabajara.intranet"
		default['stl-repo']['zbxserver'] = "zbxprx04.tabajara.intranet" 
end 
