#
# Cookbook:: stl-kubernetes-single-master
# Recipe:: k8s-master
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# includes
include_recipe "stl-repo::docker"
include_recipe "stl-docker"

# preparando o ambiente

if node["fqdn"] ==  node["infra"]["cluster-master"]
  yum_package "nfs-utils" do
    allow_downgrade true
    not_if { File.exist? ("/usr/lib/systemd/system/nfs.service") }
    action [:install]
  end

  service "rpcbind" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-server" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-lock" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-idmap" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  ppath = node["infra"][node.chef_environment]["nfs_path"]
  directory "#{ppath}" do
    owner "root"
    group "root"
    mode 0755
    action :create
  end

  template "/etc/exports.d/k8s.exports" do
    owner "root"
    group "root"
    mode 0644
    source "etc/exports.d/k8s.exports.erb"
    notifies :restart, "service[nfs-server]", :immediately
  end

  execute "applying exportfs" do
    command "exportfs -a"
    action :run
  end
end

# entregando o arquivo do repo do kubernetes no servidores
cookbook_file "/etc/yum.repos.d/kubernetes.repo" do
  source "etc/yum.repos.d/kubernetes.repo"
  owner "root"
  group "root"
  mode 0755
  action :create
end

cookbook_file "/etc/yum.repos.d/docker-ce.repo" do
  source "etc/yum.repos.d/docker-ce.repo"
  owner "root"
  group "root"
  mode 0755
  action :create
end

# instalando pacotes iniciais
yum_package "kubelet" do
  allow_downgrade true
  version node["infra"]["kubelet"]["version"]
  not_if { File.exist? ("/bin/kubelet") }
  action [:install]
end

yum_package "kubeadm" do
  allow_downgrade true
  version node["infra"]["kubeadm"]["version"]
  not_if { File.exist? ("/bin/kubeadm") }
  action [:install]
end

yum_package "kubectl" do
  allow_downgrade true
  version node["infra"]["kubectl"]["version"]
  not_if { File.exist? ("/bin/kubectl") }
  action [:install]
end

# kernel / iptables off
execute "setting 1 in /proc/sys/net/bridge/bridge-nf-call-iptables file" do
  command "modprobe br_netfilter;echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables && echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables"
  action :run
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


# enable kubelet service
execute "systemctl enable --now kubelet" do
  command "systemctl enable --now kubelet"
  action :run
end

# Desligando o swap
execute "validando-swapp-off" do
    command "swapoff -a"
    action :run
end

# Desligando o firewalld
execute "firewalld disable" do
  command "systemctl disable firewalld;systemctl stop firewalld"
  action :run
end

execute "removendo do fstab" do
    command "sed -i.bak '/swap/d' /etc/fstab"
    action :run
end

#########################################
#########################################
#

# vars
pod_network_cidr            = node["infra"]["cluster-net"]["pod_network_cidr"]
service_cidr                = node["infra"]["cluster-net"]["service_cidr"]
apiserver_advertise_address = node["infra"]["cluster-net"]["apiserver_advertise_address"]
#
nfs_share                    = node["infra"]["prod"]["nfs_path"]

execute "Make cluster" do
  command "kubeadm init --pod-network-cidr #{pod_network_cidr} --service-cidr #{service_cidr} --apiserver-advertise-address=#{apiserver_advertise_address}; kubeadm token create --ttl 0 --print-join-command > #{nfs_share}/token-insert.sh; chmod +x /share-k8s/token-insert.sh"
  action :run
  not_if {File.exist?("/etc/kubernetes/admin.conf")}
end

# weave plugin
template "/opt/weave_plugin_install.sh" do
  owner "root"
  group "root"
  mode 0755
  source "opt/weave_plugin_install.sh.erb"
end

execute "Installing Weave Net CNI Plugin" do
  command "/bin/bash /opt/weave_plugin_install.sh"
  action :run
end


