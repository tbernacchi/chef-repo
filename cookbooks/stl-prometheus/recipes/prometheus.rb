#
# Cookbook:: stl-prometheus
# Recipe:: prometheus
#
# Copyright:: 2019, The Authors, All Rights Reserved.
%w[ /opt/nginx /opt/monitoring/prometheus ].each do |path|
  recursive true
  directory "#{path}" do
  owner 'root'
  group 'root'
  mode '0755'
  not_if "{ ::Dir.exist? ( '#{path}') }"
 end
end

user 'prometheus' do
  comment 'prometheus user'
  shell '/bin/false'
  manage_home false
  comment 'prometheus user'
  action :create
  not_if "grep -q prometheus /etc/passwd"
end

%w[ /etc/prometheus /var/lib/prometheus].each do |path|
  directory "#{path}" do
  owner 'prometheus'
  group 'prometheus'
  mode '0755'
  not_if "{ ::Dir.exist? ( '#{path}') }"
 end
end

remote_file '/opt/monitoring/prometheus/prometheus.tar.gz' do 
 source 'http://repo.qa.tabajara.intranet/pacotes/prometheus-tabajara/prometheus.tar.gz'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/opt/monitoring/prometheus/prometheus.tar.gz") }  
end

bash 'Installing prometheus' do
 cwd '/opt/monitoring/prometheus'
 user 'root'
 code <<-EOF
 tar zxvf prometheus.tar.gz
 chown -R prometheus:prometheus prometheus-2.10.0.linux-amd64/
 cd prometheus-2.10.0.linux-amd64/
 cp -pr prometheus promtool /usr/bin
 cp -pr console_libraries/ /etc/prometheus
 cp -pr consoles /etc/prometheus
 cp -pr prometheus.yml /etc/prometheus
 EOF
 not_if { File.exist? ("/opt/monitoring/prometheus/prometheus.tar.gz") }  
end

%w{openssl-devel pcre-devel openldap-devel.x86_64}.each do |pkg|
 yum_package "#{pkg}" do
  action :install
  not_if "rpm -q #{pkg}"
 end
end

ruby_block "Adding FQDN on /etc/hosts" do
  block do
    fe = Chef::Util::FileEdit.new("/etc/hosts")
    fe.insert_line_if_no_match(/#{node['prometheus']['nginx'][node.chef_environment]['server_name']}/,
                               "#{node['ipaddress']} #{node['prometheus']['nginx'][node.chef_environment]['server_name']}")
    fe.write_file
  end
  not_if "grep -q #{node['prometheus']['nginx'][node.chef_environment]['server_name']} /etc/hosts"
end

systemd_unit 'prometheus.service' do
  content({Unit: {
            Description: 'Prometheus',
            Wants: 'network-online.target',
            After: 'network-online.target',
            },
            Service: {
              User: 'prometheus',
              Group: 'prometheus',
              ExecStart: '/usr/bin/prometheus \
              --config.file /etc/prometheus/prometheus.yml \
              --storage.tsdb.path /var/lib/prometheus/ \
              --web.console.templates=/etc/prometheus/consoles \
              --web.console.libraries=/etc/prometheus/console_libraries',
              ExecStop: '/bin/kill -s TERM $MAINPID',
              Restart: 'always',
              SuccessExitStatus: '143',
            },
            Install: {
              WantedBy: 'multi-user.target',
            }})
  action [ :create ]
  not_if '{ File.exist? ("/etc/systemd/system/prometheus.service") }'
  notifies :run, 'execute[daemon-reload]', :immediately
end

execute 'daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

systemd_unit 'prometheus' do 
  action [ :enable, :start ] 
end 
