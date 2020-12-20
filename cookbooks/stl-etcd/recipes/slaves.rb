execute "yum-clean-all" do
    command "yum clean all"
    action :run
end

yum_package 'etcd' do
  version '3.3.11-2.el7.centos'
  allow_downgrade true
  not_if { File.exist? ("/bin/etcd") }
  action [:install]
end

cookbook_file '/etc/etcd/etcd.conf' do
  action :delete
end

yum_package 'nfs-utils' do
  allow_downgrade true
  not_if { File.exist? ("/usr/lib/systemd/system/nfs.service") }
  action [:install]
end

%w{ /etc/etcd /etc/ssl/ /etc/ssl/etcd/ /etc/ssl/etcd/ssl }.each do |dirs|
  directory "#{dirs}" do
    owner "root"
    group "root"
    mode 0755
    action :create
  end
end

directory "/mnt/share" do
  owner "root"
  group "root"
  mode 0755
  action :create
end

pmount = node['etcd'][node.chef_environment]['nfs_mount']
ppath = node['etcd'][node.chef_environment]['nfs_path']
phost = node['etcd'][node.chef_environment]['nfs_host']
mount "#{pmount}" do
  device "#{phost}:#{ppath}"
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
  not_if { File.exist? ("/mnt/share/ca.pem") }
end

execute "Copy shared certifates to right directory" do
  command 'cp -rfv /mnt/share/* /etc/ssl/etcd/ssl/'
  action :run
  not_if { File.exist? ("/etc/ssl/etcd/ssl/ca.pem") }
end

systemd_unit 'etcd.service' do
  content({Unit: {
            Description: 'etcd',
            After: 'network.target',
          },
          Service: {
            Type: 'notify',
            User: 'etcd',
            EnvironmentFile: '/etc/etcd.env',
            ExecStart: '/usr/bin/etcd',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            NotifyAccess: 'all',
            Restart: 'always',
            RestartSec: '10s',
            SuccessExitStatus: '143',
            LimitNOFILE: '40000',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [ :create ]
end

if node.chef_environment == "qa"
  template "/etc/etcd.env" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd2.env.erb"
  end
end

if node.chef_environment == "prod"
  template "/etc/etcd.env" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd2.env-prod.erb"
  end
end

if node.chef_environment == "lab"
  template "/etc/etcd.env" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd.env-lab.erb"
  end
end

execute "Creating lock file in order to prevent generate news certificates" do
  command 'chmod -Rv 550 /etc/ssl/etcd/ && chmod 440 /etc/ssl/etcd/ssl/*.pem && chown -Rv etcd:etcd /etc/ssl/etcd/ && chown -Rv etcd:etcd /etc/ssl/etcd/* && chown etcd:etcd /var/lib/etcd/'
  action :run
end

service "etcd.service" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end
