#
# Cookbook:: stl-app-siloc
# Recipe:: share-cip-admin
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# gluster client
yum_package 'glusterfs-client' do
 action :install
 not_if { File.exist? ("/usr/lib64/glusterfs/3.12.2/xlator/protocol/client.so") }
end

# make group
group 'nfsnobody' do
  gid 65534
end

# make user
user 'nfsnobody' do
  uid 65534
  gid 65534
  shell '/bin/nologin'
end

# criado o diretorio raiz
directory "/shares" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# make dirs
%w{ /shares/credenciamento }.each do |dirs|
   directory "#{dirs}" do
     owner "root"
     group "root"
     mode 0755
     action :create
   end

  # troco a variavel para ficar so com o dev
  DEV_REM = "#{dirs}"
  DEV = "#{DEV_REM}".split("/")[2]

  mount "#{dirs}" do
    if node.chef_environment == 'prod'
       device "glusterfs.tabajara.intranet:volume-k8s-prod/#{DEV}"
    end

    if node.chef_environment == 'qa'
       device "glusterfs.tabajara.intranet:volume-k8s-qa/#{DEV}"
    end

  fstype "glusterfs"
  options "defaults,_netdev"
  action [:mount, :enable]
  end
 end

# Reinicia o daemon do sshd
execute "daemon-sshd-restart" do
 user "root"
 command "systemctl restart sshd"
 action :nothing
end

# Entregamos o arquivo do sshd com os bloqueios necessarios
cookbook_file '/etc/ssh/sshd_config' do
  source 'etc/ssh/sshd_config'
  owner 'root'
  group 'root'
  mode '0600'
  action :create
  notifies :run, 'execute[daemon-sshd-restart]', :immediately
end
