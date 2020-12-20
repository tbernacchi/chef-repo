#
# Cookbook:: stl-institucional
# Recipe:: user-dir
#
# Copyright:: 2018, The Authors, All Rights Reserved.
user 'imagens' do
 comment 'imagens user'
 system true 
 shell '/sbin/nologin'
 action :create
 not_if "grep -q imagens /etc/passwd" 
end

directory "/home/imagens/email" do
 owner "imagens"
 group "imagens"
 mode 0755
 action :create
 recursive true
end

