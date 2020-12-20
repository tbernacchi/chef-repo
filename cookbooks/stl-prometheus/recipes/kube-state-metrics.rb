#
# Cookbook:: stl-prometheus
# Recipe:: kube-state-metrics
#
# Copyright:: 2019, The Authors, All Rights Reserved.
%w[ /opt/monitoring/kube-state-metrics /opt/kubernetes].each do |path|
directory "#{path}" do
 owner 'root'
 group 'root'
 mode '0755'
 recursive true 
 not_if "{ ::Dir.exist? ( '#{path}') }"
 end
end

remote_file '/opt/monitoring/kube-state-metrics/kube-state-metrics.tar.gz' do 
 source 'http://repo.qa.tabajara.intranet/pacotes/prometheus/kube-state-metrics.tar.gz'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/opt/kube-state-metrics/kube-state-metrics.tar.gz") }  
end

bash 'Installing kube-state-metrics' do
 cwd '/opt/monitoring/kube-state-metrics'
 user 'root'
 code <<-EOF
 tar zxvf kube-state-metrics.tar.gz
 chown -R prometheus:prometheus kube-state-metrics/
 EOF
 not_if { File.exist? ("/opt/monitoring/kube-state-metrics/kube-state-metrics.tar.gz") }  
end

%w ( lab qa prod ].each do |env| 
cookbook_file "/etc/security/limits.conf" do
 source "limits/limits.conf"
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if "grep -q 65000 /etc/security/limits.conf"
 notifies :run, 'execute[sysctl]', :immediately
end

systemd_unit 'kube-state-metrics.service' do
  content({Unit: {
            Description: 'kube-state-metrics',
            Wants: 'network-online.target',
            After: 'network-online.target',
            },
            Service: {
              Type:'simple',
              WorkingDirectory:'/opt/monitoring/kube-state-metrics',
              ExecStart:'/opt/monitoring/kube-state-metrics/kube-state-metrics --port=8085 --telemetry-port=8086 --kubeconfig=/opt/kubernetes/admin.conf /opt/kube-state-metrics',
            },
            Install: {
              WantedBy: 'multi-user.target',
            }})
  action [ :create ]
  not_if '{ File.exist? ("/etc/systemd/system/kube-state-metrics.service") }'
  notifies :run, 'execute[daemon-reload]', :immediately
end

execute 'daemon-reload' do
  command 'systemctl daemon-reload'
  action :nothing
end

systemd_unit 'kube-state-metrics' do 
  action [ :enable, :start ] 
end 
