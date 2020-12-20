#
# Cookbook:: stl-rundeck
# Recipe:: rundeck-deploy-app
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
directory "/usr/local/bin/rundeck-deploy/" do
 owner "svc_deploy_prod"
 group "nobody"
 mode 0755
 action :create
 recursive true
end

cookbook_file "/usr/local/bin/rundeck-deploy/promote-pkg-to-prod.sh" do
 source "promote-pkg-to-prod.sh"
 owner "svc_deploy_prod"
 group "nobody"
 mode "0755"
 action :create
end

cookbook_file "/usr/local/bin/rundeck-deploy/deploy.sh" do
 source "deploy.sh"
 owner "svc_deploy_prod"
 group "nobody"
 mode "0755"
 action :create
end

template "/etc/sudoers.d/rundeck-chef" do
 source "etc/sudoers.d/rundeck-chef.erb"
 owner "root"
 group "root"
 mode 0644
end
