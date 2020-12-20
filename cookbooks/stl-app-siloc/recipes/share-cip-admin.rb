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

 # make dirs
 %w{ /shares /shares/silocarquivos /shares/dfinarquivos /shares/vol-dirf }.each do |dirs|
   directory "#{dirs}" do
     owner "root"
     group "root"
     mode 0755
     action :create
   end
 end

# mount point
mount "/shares/silocarquivos" do
 device "glusterfs.tabajara.intranet:/volume-cip"
 fstype "glusterfs"
 options "defaults,_netdev"
 action [:mount, :enable]
end

mount "/shares/dfinarquivos" do
 device "glusterfs.tabajara.intranet:/volume-dfin"
 fstype "glusterfs"
 options "defaults,_netdev"
 action [:mount, :enable]
end

mount "/shares/vol-dirf" do
 device "glusterfs.tabajara.intranet:/volume-dirf"
 fstype "glusterfs"
 options "defaults,_netdev"
 action [:mount, :enable]
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

# Entregando para copia do arquivo do ECF para o office
cookbook_file '/usr/local/bin/transfer-file/transfer-dfin-ecf.sh' do
  source 'bin/transfer-dfin-ecf.sh'
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end


