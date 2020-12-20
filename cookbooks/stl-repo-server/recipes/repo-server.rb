#
# Cookbook:: stl-repo-server
# Recipe:: repo-server
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# install httpd package
yum_package 'httpd' do
    allow_downgrade true
    package_name  'httpd'
    version       '2.4.6-80.el7.centos.1.x86_64'
    action        [ :install]
    not_if        "test -f /usr/sbin/httpd"
end

#### 
# httpd.conf + includes
cookbook_file '/etc/httpd/conf/httpd.conf' do
  source 'httpd/conf/httpd.conf'
  owner 'root'
  group 'root'
  mode 0644
  action :create
  notifies :run, 'execute[daemon-httpd-restart]', :immediately
end

# includes
cookbook_file '/etc/httpd/conf.d/1-repo-prod.conf' do
  source 'httpd/conf.d/1-repo-prod.conf'
  owner 'root'
  group 'root'
  mode 0644
  action :create
  notifies :run, 'execute[daemon-httpd-restart]', :immediately
end

# includes
cookbook_file '/etc/httpd/conf.d/2-repo-devqa.conf' do
  source 'httpd/conf.d/2-repo-devqa.conf'
  owner 'root'
  group 'root'
  mode 0644
  action :create
  notifies :run, 'execute[daemon-httpd-restart]', :immediately
end

# cron
cookbook_file '/etc/cron.d/sync-repos' do
  source 'crond/sync-repos'
  owner 'root'
  group 'root'
  mode 0644
  action :create
end

# Cria o diretorio
directory "/usr/local/bin/repo" do
  action :create
  recursive true
  owner "nobody"
  group "nobody"
  mode 0644
  action :create
end

# Cria o diretorio
directory "/var/sources" do
  action :create
  recursive true
  owner "root"
  group "root"
  mode 0644
  action :create
end

%w{ rundeck.repo baculum.repo CentOS-Base.repo.original CentOS-Debuginfo.repo CentOS-Media.repo centos-tabajara.repo epel.repo CentOS-Base.repo CentOS-CR.repo CentOS-fasttrack.repo CentOS-Sources.repo CentOS-Vault.repo epel-testing.repo mongo.repo kubernetes.repo }.each do |file|
  cookbook_file "/var/sources/#{file}" do
    source "var/sources/#{file}"
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
end

# scripts
cookbook_file '/usr/local/bin/repo/sync_repo.sh' do
  source 'bin/repo/sync_repo.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/repo/create-repo-dev-2-prod.sh' do
  source 'bin/repo/create-repo-dev-2-prod.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/repo/create-repo-dev-2-devqa.sh' do
  source 'bin/repo/create-repo-dev-2-devqa.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end

cookbook_file '/usr/local/bin/repo/purge-old-rpms.sh' do
  source 'bin/repo/purge-old-rpms.sh'
  owner 'root'
  group 'root'
  mode 0755
  action :create
end


#Reinicia o daemon do httpd
execute "daemon-httpd-restart" do
  user "root"
  command "systemctl restart httpd"
  action :nothing
end

# Criando os links
link '/var/www/html/prod/isos_and_templates' do
  to '/repo/isos_and_templates'
end  

link '/var/www/html/prod/pacotes' do
  to '/repo/pacotes'
end

link '/var/www/html/devqa/pacotes' do
  to '/repo/pacotes'
end


link '/var/www/html/prod/repos' do
  to '/repo/repos/'
end

link '/var/www/html/devqa/repos' do
  to '/repo/repos/'
end


link '/var/www/html/prod/tabajarapackages' do
  to '/repo/pacotes/tabajarapackages'
end

link '/var/www/html/devqa/tabajarapackages' do
  to '/repo/pacotes/tabajarapackages-qa'
end

link '/var/www/html/repos' do
  to '/repo/repos'
end
