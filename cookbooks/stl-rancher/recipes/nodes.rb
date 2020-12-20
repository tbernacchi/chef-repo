yum_package 'docker-ce' do
  version '18.09.3-3.el7'
  allow_downgrade true
end

mount '/var/lib/docker' do
  device '/dev/rancher/container1'
  fstype 'xfs'
  options 'defaults'
  pass 0
  action [:mount, :enable]
  not_if { File.exist? ("/var/lib/docker/buildkit/metadata.db") }
end

service "docker" do
 supports :start => true, :stop => true, :restart => true, :status => true
 action [:enable, :start]
end

template "/etc/docker/daemon.json" do
  owner "root"
  group "root"
  mode 0644
  source "etc/docker/daemon.json.erb"
  notifies :restart, "service[docker]", :delayed
end

template "/etc/docker/seccomp.json" do
  owner "root"
  group "root"
  mode 0644
  source "etc/docker/seccomp.json.erb"
  notifies :restart, "service[docker]", :delayed
end

template "/etc/systemd/system/docker.service.d/http-proxy.conf" do
  owner "root"
  group "root"
  mode 0644
  source "etc/systemd/system/docker.service.d/http-proxy.conf.erb"
  notifies :restart, "service[docker]", :delayed
end

yum_package 'etcd' do
  allow_downgrade true
  not_if { File.exist? ("/sbin/keepalived") }
  action [:install]
end

template "/etc/systemd/system/etcd.service" do
  owner "root"
  group "root"
  mode 0644
  source "etc/systemd/system/etcd.service.erb"
end

yum_package 'keppalived' do
  allow_downgrade true
  not_if { File.exist? ("/sbin/keepalived") }
  action [:install]
end

template "/etc/keepalived/keepalived.conf" do
  owner "root"
  group "root"
  mode 0644
  source "etc/keepalived/keepalived.conf-nodes.erb"
end
