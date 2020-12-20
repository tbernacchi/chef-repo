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

%w{ /var/lib/rundeck/var /var/lib/rundeck/var/storage /var/lib/rundeck/var/storage/content /var/lib/rundeck/var/storage/content/keys /var/lib/rundeck/var/storage/content/keys/nodes }.each do |dirs|
    directory "#{dirs}" do
    owner "rundeck"
    group "rundeck"
    mode 0750
    action :create
  end
end

cookbook_file '/usr/local/bin/rundeck/rundeck-project-create.sh' do
  source 'bin/rundeck/rundeck-project-create.sh'
  owner 'rundeck'
  group 'rundeck'
  mode 0700
  action :create
end

# criacao do project e seu resources.xml
%w{ m1 credenciamento pagamento api-monitor infra-admin transacional siloc portaladmin cadu-2.0 api-transacional agendamento-pagamento-tif dfin infra-noc infra-virtualizacao mis sustentacao street fornecedores pre-pago relatorios }.each do |projects|
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

cookbook_file '/usr/local/bin/rundeck/make-keys.sh' do
  source 'bin/rundeck/make-keys.sh'
  owner 'rundeck'
  group 'rundeck'
  mode 0755
  action :create
end

execute 'make-keys' do
  command "/usr/local/bin/rundeck/make-keys.sh"
  action :nothing
end

# enquanto nao tem owner no git
cookbook_file "/var/rundeck/keys/keylist.db" do
  source "keys/keylist.db"
  owner 'rundeck'
  group 'rundeck'
  mode 0700
  action :create
  notifies :run, 'execute[make-keys]', :immediately
end

## ACL
# policy
cookbook_file '/etc/rundeck/admin.aclpolicy' do
  source 'etc/rundeck/admin.aclpolicy'
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  action :create
end

cookbook_file '/etc/rundeck/desenvolvimento.aclpolicy' do
  source 'etc/rundeck/desenvolvimento.aclpolicy'
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  action :create
end

cookbook_file '/etc/rundeck/implantacao.aclpolicy' do
  source 'etc/rundeck/implantacao.aclpolicy'
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  action :create
end

cookbook_file '/etc/rundeck/infraestrutura_admin.aclpolicy' do
  source 'etc/rundeck/infraestrutura_admin.aclpolicy'
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  action :create
end

cookbook_file '/etc/rundeck/noc.aclpolicy' do
  source 'etc/rundeck/noc.aclpolicy'
  owner 'rundeck'
  group 'rundeck'
  mode 0644
  action :create
end
