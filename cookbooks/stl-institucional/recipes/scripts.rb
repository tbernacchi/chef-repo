#
# Cookbook:: stl-institucional
# Recipe:: scripts
#
# Copyright:: 2019, The Authors, All Rights Reserved.
cookbook_file '/etc/cron.d/sync_images_glusterfs' do
  source 'crond/sync_images_glusterfs'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/etc/cron.d/backup_public_html' do
  source 'crond/backup_public_html'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

cookbook_file '/usr/local/bin/sync_fachada01_public.sh' do
  source 'bin/sync_fachada01_public.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/sync_fachada01_imagens.sh' do
  source 'bin/sync_fachada01_imagens.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/sync_images_glusterfs.sh' do
  source 'bin/sync_images_glusterfs.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory "/root/public_html_backup" do
  action :create
  owner "root"
  group "root"
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/clean_public_html_backup.sh' do
  source 'backup/clean_public_html_backup.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/usr/local/bin/public_html_backup.sh' do
  source 'backup/public_html_backup.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
