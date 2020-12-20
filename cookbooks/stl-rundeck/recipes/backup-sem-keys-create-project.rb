#
# Cookbook:: stl-rundeck
# Recipe:: create-project
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#

directory '/usr/local/bin/rundeck' do
    owner 'rundeck'
    group 'rundeck'
    mode 0700
    recursive true
    action :create
end

cookbook_file '/usr/local/bin/rundeck/rundeck-project-create.sh' do
  source 'bin/rundeck/rundeck-project-create.sh'
  owner 'rundeck'
  group 'rundeck'
  mode 0700
  action :create
end

# criacao do project e seu resources.xml
%w{ teste_final_em_cluster teste-com-gluster }.each do |projects|

  execute "#{projects}" do
    command "sh /usr/local/bin/rundeck/rundeck-project-create.sh add #{projects}"
  end

  path_prj = "/var/rundeck/projects/#{projects.upcase}/etc/resources.xml"
  path_source_resource = "projects/#{projects.upcase}/etc/resources.xml"

  cookbook_file "#{path_prj}" do
    source "#{path_source_resource}"
    owner 'rundeck'
    group 'rundeck'
    mode 0700
    action :create
  end
end
