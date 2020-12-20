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

# Criando as chaves
directory '/var/rundeck/keys' do
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
%w{ teste_final_em_cluster }.each do |projects|
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

  execute 'make-keys' do
    command "/usr/local/bin/rundeck/make-keys.sh key #{projects.upcase}"
    action :nothing
  end

  path_keys = "/var/rundeck/keys/#{projects.upcase}"
  path_source_keys = "keys/#{projects.upcase}"

  directory "#{path_keys}" do
    owner 'rundeck'
    group 'rundeck'
    mode 0700
    action :create
  end

  cookbook_file "#{path_keys}/keylist.db" do
    source "#{path_source_keys}/keylist.db"
    owner 'rundeck'
    group 'rundeck'
    mode 0700
    action :create
    notifies :run, 'execute[make-keys]', :immediately
  end
end

cookbook_file '/usr/local/bin/rundeck/make-keys.sh' do
  source 'bin/rundeck/make-keys.sh'
  owner 'rundeck'
  group 'rundeck'
  mode 0755
  action :create
end
