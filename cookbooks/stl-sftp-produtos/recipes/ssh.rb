#
# Cookbook:: stl-sftp-produtos
# Recipe:: ssh
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/etc/ssh/sshd_config' do
  source 'sshd_config'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-sshd-restart]', :immediately
end

execute "daemon-sshd-restart" do
 user "root"
 command "systemctl restart sshd"
 action :nothing
end
