#
# Cookbook:: stl-proxy-squid
# Recipe:: stl-monit-urls
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# script que pega o log do squid com seek

# Cria o diretorio
directory "/usr/local/bin/seek-urls" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

cookbook_file '/usr/local/bin/seek-urls/seek-grep-access.sh' do
  source 'bin/seek-urls/seek-grep-access.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/etc/cron.d/exec-seek-grep-access.sh' do
  source 'crond/exec-seek-grep-access.sh'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end


