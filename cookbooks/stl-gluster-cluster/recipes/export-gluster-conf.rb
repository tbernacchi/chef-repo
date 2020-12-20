#
# Cookbook:: stl-gluster-cluster
# Recipe:: export-gluster-conf
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Cria o diretorio
directory "/usr/local/bin/gluster" do
    action :create
    recursive true
    owner "root"
    group "root"
    mode 0755
    action :create
end

cookbook_file '/usr/local/bin/gluster/get-gluster-conf.sh' do
  source 'bin/gluster/get-gluster-conf.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/etc/cron.d/exec-get-gluster-conf.sh' do
  source 'crond/exec-get-gluster-conf.sh'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end
