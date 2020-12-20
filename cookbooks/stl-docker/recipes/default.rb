include_recipe 'stl-repo::docker'

execute "yum-clean-all" do
    command "yum clean all"
    action :run
end

execute "validando-swapp-off" do
    command "swapoff -a"
    action :run
end

execute "removendo do fstab" do
    command "sed -i.bak '/swap/d' /etc/fstab"
    action :run
end

yum_package 'docker-ce' do
  version '18.06.3.ce-3.el7'
  allow_downgrade true
  not_if { File.exist? ("/bin/docker") }
  action [:install]
end

%w{yum-utils device-mapper-persistent-data lvm2 htop}.each do |pkgs|
  yum_package "#{pkgs}" do
    allow_downgrade true
    action [:upgrade]
  end
end

service "docker" do
 supports :start => true, :stop => true, :restart => true, :status => true
 action [:enable, :start]
end

directory "/etc/systemd/system/docker.service.d" do
  owner "root"
  group "root"
  mode 0755
  action :create
 end

template "/etc/docker/daemon.json" do
 owner "root"
 group "root"
 mode 0644
 source "etc/docker/daemon.json.erb"
 notifies :restart, "service[docker]", :delayed
end

template "/etc/systemd/system/docker.service.d/http-proxy.conf" do
  owner "root"
  group "root"
  mode 0644
  source "etc/systemd/system/docker.service.d/http-proxy.conf.erb"
  notifies :restart, "service[docker]", :immediately
end
