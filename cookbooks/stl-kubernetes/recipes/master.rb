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

directory "/etc/kubernetes/pki" do
  owner "root"
  group "root"
  mode 0755
  recursive true
  action :create
end

execute "setting 1 in /proc/sys/net/bridge/bridge-nf-call-iptables file " do
  command 'echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables && echo 1 > /proc/sys/net/bridge/bridge-nf-call-ip6tables'
  action :run
end

if node['fqdn'] == 'hzubernetes01.qa.tabajara.intranet'
  yum_package 'nfs-utils' do
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

  ppath = node['k8s'][node.chef_environment]['nfs_path']
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
    command 'exportfs -a'
    action :run
  end

  template "/opt/kubeadmcfg.yaml" do
    owner "root"
    group "root"
    mode 0644
    source "opt/kubeadmcfg.yaml.erb"
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
    source "etc/keepalived/keepalived.conf-m0.erb"
    notifies :restart, "service[keepalived]", :delayed
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

  template "/opt/kube_keygen.sh" do
    owner "root"
    group "root"
    mode 0755
    source "opt/kube_keygen.sh.erb"
  end

  template "/opt/weave_plugin_install.sh" do
    owner "root"
    group "root"
    mode 0755
    source "opt/weave_plugin_install.sh.erb"
  end

  execute "creating keys and certificates to K8s" do
    command '/bin/bash /opt/kube_keygen.sh'
    action :run
    not_if { File.exist? ("/etc/kubernetes/pki/ca.key") }
  end

  execute "creating cluster - output is in /mnt/k8s_install/create_cluster_output.txt" do
    command 'kubeadm init --token-ttl=0 --config /opt/kubeadmcfg.yaml >> /mnt/k8s_install/create_cluster_output.txt && mkdir -p /root/.kube && sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config && sudo chown root:root root/.kube/config'
    action :run
    not_if { File.exist? ("/mnt/k8s_install/create_cluster_output.txt") }
  end

  execute "Installing Weave Net CNI Plugin" do
    command '/bin/bash /opt/weave_plugin_install.sh'
    action :run
  end

  execute "Copying all certifcates files to directory shared with another master nodes" do
    command 'cp -rf /etc/kubernetes/pki/* /mnt/k8s_install/'
    action :run
    not_if { File.exist? ("/mnt/k8s_install/ca.key") }
  end

  execute "Copying all shared certifcates files to kubernetes" do
    command 'cp -rf /mnt/k8s_install/*.{crt,key,pub} /etc/kubernetes/pki/'
    action :run
    not_if { File.exist? ("/etc/kubernetes/pki/ca.key") }
  end

  service "kubelet" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end
end

if node['fqdn'] == 'zubernetes01.tabajara.intranet'
  yum_package 'nfs-utils' do
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

  ppath = node['k8s'][node.chef_environment]['nfs_path']
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
    command 'exportfs -a'
    action :run
  end

  template "/opt/kubeadmcfg.yaml" do
    owner "root"
    group "root"
    mode 0644
    source "opt/kubeadmcfg.yaml.erb"
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
    source "etc/keepalived/keepalived.conf-m0.erb"
    notifies :restart, "service[keepalived]", :delayed
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

  template "/opt/kube_keygen.sh" do
    owner "root"
    group "root"
    mode 0755
    source "opt/kube_keygen.sh.erb"
  end

  template "/opt/weave_plugin_install.sh" do
    owner "root"
    group "root"
    mode 0755
    source "opt/weave_plugin_install.sh.erb"
  end

  execute "creating keys and certificates to K8s" do
    command '/bin/bash /opt/kube_keygen.sh'
    action :run
    not_if { File.exist? ("/etc/kubernetes/pki/ca.key") }
  end

  execute "creating cluster - output is in /mnt/k8s_install/create_cluster_output.txt" do
    command 'kubeadm init --token-ttl=0 --config /opt/kubeadmcfg.yaml >> /mnt/k8s_install/create_cluster_output.txt && mkdir -p /root/.kube && sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config && sudo chown root:root root/.kube/config'
    action :run
    not_if { File.exist? ("/mnt/k8s_install/create_cluster_output.txt") }
  end

  execute "Installing Weave Net CNI Plugin" do
    command '/bin/bash /opt/weave_plugin_install.sh'
    action :run
  end

  execute "Copying all certifcates files to directory shared with another master nodes" do
    command 'cp -rf /etc/kubernetes/pki/* /mnt/k8s_install/'
    action :run
    not_if { File.exist? ("/mnt/k8s_install/ca.key") }
  end

  execute "Copying all shared certifcates files to kubernetes" do
    command 'cp -rf /mnt/k8s_install/*.{crt,key,pub} /etc/kubernetes/pki/'
    action :run
    not_if { File.exist? ("/etc/kubernetes/pki/ca.key") }
  end

  service "kubelet" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end
end

if node['fqdn'] == 'zaster01.tabajara.intranet'
  yum_package 'nfs-utils' do
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

  ppath = node['k8s'][node.chef_environment]['nfs_path']
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
    command 'exportfs -a'
    action :run
  end

  template "/opt/kubeadmcfg.yaml" do
    owner "root"
    group "root"
    mode 0644
    source "opt/kubeadmcfg.yaml.erb"
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
    source "etc/keepalived/keepalived.conf-m0.erb"
    notifies :restart, "service[keepalived]", :delayed
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

  template "/opt/kube_keygen.sh" do
    owner "root"
    group "root"
    mode 0755
    source "opt/kube_keygen.sh.erb"
  end

  template "/opt/weave_plugin_install.sh" do
    owner "root"
    group "root"
    mode 0755
    source "opt/weave_plugin_install.sh.erb"
  end

  execute "creating keys and certificates to K8s" do
    command '/bin/bash /opt/kube_keygen.sh'
    action :run
    not_if { File.exist? ("/etc/kubernetes/pki/ca.key") }
  end

  execute "creating cluster - output is in /mnt/k8s_install/create_cluster_output.txt" do
    command 'kubeadm init --token-ttl=0 --config /opt/kubeadmcfg.yaml >> /mnt/k8s_install/create_cluster_output.txt && mkdir -p /root/.kube && sudo cp -i /etc/kubernetes/admin.conf /root/.kube/config && sudo chown root:root root/.kube/config'
    action :run
    not_if { File.exist? ("/mnt/k8s_install/create_cluster_output.txt") }
  end

  execute "Installing Weave Net CNI Plugin" do
    command '/bin/bash /opt/weave_plugin_install.sh'
    action :run
  end

  execute "Copying all certifcates files to directory shared with another master nodes" do
    command 'cp -rf /etc/kubernetes/pki/* /mnt/k8s_install/'
    action :run
    not_if { File.exist? ("/mnt/k8s_install/ca.key") }
  end

  execute "Copying all shared certifcates files to kubernetes" do
    command 'cp -rf /mnt/k8s_install/*.{crt,key,pub} /etc/kubernetes/pki/'
    action :run
    not_if { File.exist? ("/etc/kubernetes/pki/ca.key") }
  end

  service "kubelet" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end
end
