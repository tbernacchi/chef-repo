#
# Cookbook:: stl-portal-app
# Recipe:: portal-app.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Entrega de arquivos do cron
## monitoria do requests na SL
cookbook_file '/etc/logrotate.d/portal' do
  source 'logrotate.d/portal'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end
