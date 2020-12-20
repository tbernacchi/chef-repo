#
# Cookbook:: stl-app-sms-mail
# Recipe:: app-sms-mail-monit
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
# Cria o diretorio
directory "/usr/local/bin/selftest" do
	action :create
	recursive true
	owner "nobody"
	group "nobody"
	mode 0644
	action :create
end

# Entrega o arquivo de selftest (exec) no pool-zair
%w{zair01.tabajara.intranet zair02.tabajara.intranet}.each do |srv|
	if node['fqdn'] == srv
		cookbook_file '/usr/local/bin/selftest/self-test-sms-email.sh' do
			source 'selftest/self-test-sms-email.sh'
			owner 'root'
			group 'root'
			mode '0755'
			action :create
		end
	end
end


# Entrega o arquivo de selftest (exec) no pool-monit-infra
%w{monit-infra01.tabajara.intranet monit-infra02.tabajara.intranet}.each do |srv|
	if node['fqdn'] == srv
		cookbook_file '/usr/local/bin/selftest/exec-selftest-email-sms.sh' do
			source 'selftest/exec-selftest-email-sms.sh'
			owner 'root'
			group 'root'
			mode '0755'
			action :create
		end
	end
end


