#
# Cookbook:: stl-kubernetes
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
include_recipe 'stl-repo::docker'
include_recipe 'stl-repo::kubernetes'
include_recipe 'stl-docker'

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

yum_package 'glusterfs-client' do
   action :install
   not_if { File.exist? ("/usr/lib64/glusterfs/3.12.2/xlator/protocol/client.so") }
end

directory "/opt/dfinarquivos" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

dfin_path = node['k8s'][node.chef_environment]['dfin_vol']
mount "/opt/dfinarquivos" do
 device "glusterfs.tabajara.intranet:#{dfin_path}"
 fstype "glusterfs"
 options "defaults,_netdev"
 action [ :mount, :enable ]
 not_if { File.exist? ("/opt/dfinarquivos/.naoapagar") }
end

if node.chef_environment == "qa"
  directory "/opt/spagarquivos" do
    owner "root"
    group "root"
    mode 0755
    recursive true
    action :create
  end

  spag_path = node['k8s'][node.chef_environment]['gfs_path_apps']
  mount "/opt/spagarquivos" do
   device "glusterfs.tabajara.intranet:#{spag_path}"
   fstype "glusterfs"
   options "defaults,_netdev"
   action [ :mount, :enable ]
   not_if { File.exist? ("/opt/spagarquivos/.naoapagar") }
  end

  directory "/opt/spag" do
    owner "root"
    group "root"
    mode 0755
    recursive true
    action :create
  end

  spag_app_path = node['k8s'][node.chef_environment]['spag_path_apps']
  mount "/opt/spag" do
   device "hquadrante01.qa.tabajara.intranet:#{spag_app_path}"
   fstype "nfs"
   options "rw"
   action [ :mount, :enable ]
   not_if { File.exist? ("/opt/spag/.naoapagar") }
  end

  directory "/opt/dfinarquivos" do
    owner "root"
    group "root"
    mode 0755
    recursive true
    action :create
  end

  mount '/opt/dfinarquivos' do
    device 'hquadrante01.qa.tabajara.intranet:/opt/dfinarquivos'
    fstype 'nfs'
    options 'rw'
    action [ :mount, :enable ]
  end
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

template "/opt/insert_worker_on_cluster.sh" do
  owner "root"
  group "root"
  mode 0644
  source "/opt/insert_worker_on_cluster.sh.erb"
  not_if { File.exist? ("/opt/insert_worker_on_cluster.sh") }
end

execute "Inserting worker node in cluster kubernetes " do
  command '/bin/bash /opt/insert_worker_on_cluster.sh'
  action :run
end
