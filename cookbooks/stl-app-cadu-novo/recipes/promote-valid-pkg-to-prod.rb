#
# Cookbook:: stl-app-cadu-novo
# Recipe:: promote-pkg-rundeck
#
# Copyright:: 2019, The Authors, All Rights Reserved.
directory "/usr/local/bin/validacao/" do
 recursive true
 owner "svc-validacao"
 group "nobody"
 mode 0755
 action :create
end

cookbook_file "/usr/local/bin/validacao/promote-valid-pkg-to-prod.sh" do
 source "promote-valid-pkg-to-prod.sh"
 owner "svc-validacao"
 group "nobody"
 mode "0755"
 action :create
end

