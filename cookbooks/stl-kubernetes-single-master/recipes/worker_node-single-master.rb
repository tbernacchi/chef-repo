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
  version node['infra']['kubectl']['version']
  not_if { File.exist? ("/bin/kubectl") }
  action [:install]
end

yum_package 'kubelet' do
  allow_downgrade true
  version node['infra']['kubelet']['version']
  not_if { File.exist? ("/bin/kubelet") }
  action [:install]
end

yum_package 'kubeadm' do
  allow_downgrade true
  version node['infra']['kubeadm']['version']
  not_if { File.exist? ("/bin/kubeadm") }
  action [:install]
end

yum_package 'glusterfs-client' do
   action :install
   not_if { File.exist? ("/usr/lib64/glusterfs/3.12.2/xlator/protocol/client.so") }
end

# net
execute "setting 1 in /proc/sys/net/bridge/bridge-nf-call-iptables file " do
  command 'modprobe br_netfilter; echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables && echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables'
  action :run
end

# Desligando o firewalld
execute "firewalld disable" do
  command "systemctl disable firewalld;systemctl stop firewalld"
  action :run
end


directory "/etc/kubernetes/pki" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
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

yum_package 'nfs-utils' do
  allow_downgrade true
  not_if { File.exist? ("/usr/lib/systemd/system/nfs.service") }
  action [:install]
end

# NFS para obter o comando com token para ingressar no cluster
directory "/share-k8s" do
    owner "root"
    group "root"
    mode 0755
    recursive true
    action :create
  end

mount '/share-k8s' do
    device 'zica01.tabajara.intranet:/share-k8s'
    fstype 'nfs'
    options 'rw'
    action [ :mount, :enable ]
end

# Inserindo  worker no cluster
execute "Adicionando worker no Cluster " do
  command "/share-k8s/token-insert.sh"
  action :run
  not_if {File.exist?("/etc/kubernetes/kubelet.conf")}

end

