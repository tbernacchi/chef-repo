#
# Cookbook:: stl-app-cadu-novo
# Recipe:: rundeck_deploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.
directory "/usr/local/bin/validacao/" do
 recursive true
 owner "svc-validacao"
 group "nobody"
 mode 0755
 action :create
end

cookbook_file "/usr/local/bin/validacao/deploy.sh" do
 source "deploy.sh"
 owner "svc-validacao"
 group "nobody"
 mode "0755"
 action :create
end

