if node.chef_environment == 'prod' 
	default['stl-spacewalk']['baseurl'] = "repo.tabajara.intranet"
	default['stl-spacewalk']['server_name'] = "zspace01.tabajara.intranet"
	default['stl-spacewalk']['activationkey'] = "1-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	default['stl-spacewalk']['interval_rhnsd'] = "240"
end 
