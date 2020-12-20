#
# Cookbook:: stl-kubernetes
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-repo::docker'
include_recipe 'stl-repo::kubernetes'
include_recipe 'stl-docker'
include_recipe 'stl-keepalived'

yum_package 'kubectl' do
  allow_downgrade true
  version node['k8s']['kubectl']['version']
  not_if { File.exist? ("/bin/kubectl") }
  action [:install]
end

yum_package 'kubelet' do
  allow_downgrade true
  version node['k8s']['kubelet']['version']
  not_if { File.exist? ("/bin/kubelet") }
  action [:install]
end

yum_package 'kubeadm' do
  allow_downgrade true
  version node['k8s']['kubeadm']['version']
  not_if { File.exist? ("/bin/kubeadm") }
  action [:install]
end

execute "setting 1 in /proc/sys/net/bridge/bridge-nf-call-iptables file " do
  command 'echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables && echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables'
  action :run
end

yum_package 'nfs-utils' do
  allow_downgrade true
  not_if { File.exist? ("/usr/lib/systemd/system/nfs.service") }
  action [:install]
end

directory "/etc/kubernetes/pki" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

directory "/mnt/k8s_nodes" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

phost = node['k8s'][node.chef_environment]['M01_fqdn']
pmount = node['k8s'][node.chef_environment]['nfs_path']
mount '/mnt/k8s_nodes' do
  device "#{phost}:#{pmount}"
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
 end

service "keepalived" do
 supports :start => true, :stop => true, :restart => true, :status => true
 action [:enable, :start]
end

template "/etc/keepalived/check_apiserver.sh" do
  owner "root"
  group "root"
  mode 0644
  source "etc/keepalived/check_apiserver.sh.erb"
  notifies :restart, "service[keepalived]", :delayed
end

template "/etc/keepalived/keepalived.conf" do
  owner "root"
  group "root"
  mode 0644
  source "etc/keepalived/keepalived.conf-nodes.erb"
  notifies :restart, "service[keepalived]", :delayed
end

execute "Copying all shared certifcates files to kubernetes" do
  command 'cp -rf /mnt/k8s_nodes/*.{crt,key,pub} /etc/kubernetes/pki/'
  action :run
  not_if { File.exist? ("/etc/kubernetes/pki/ca.key") }
end

service "kubelet" do
 supports :start => true, :stop => true, :restart => true, :status => true
 action [:enable, :start]
end

template "/usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf" do
  owner "root"
  group "root"
  mode 0644
  source "usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf.erb"
  notifies :restart, "service[kubelet]", :immediately
end

template "/opt/insert_master_on_cluster.sh" do
  owner "root"
  group "root"
  mode 0644
  source "/opt/insert_master_on_cluster.sh.erb"
  not_if { File.exist? ("/opt/insert_master_on_cluster.sh") }
end

execute "Inserting master node in cluster kubernetes " do
  command '/bin/bash /opt/insert_master_on_cluster.sh'
  action :run
end
