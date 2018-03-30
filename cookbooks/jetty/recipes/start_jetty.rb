#
# Cookbook:: jetty
# Recipe:: start_jetty
#
# Copyright:: 2018, The Authors, All Rights Reserved.

bash 'Disable IPv6' do
 code <<-EOF
 echo net.ipv6.conf.all.disable_ipv6 = 1 >> /etc/sysctl.conf
 echo net.ipv6.conf.default.disable_ipv6 = 1 >> /etc/sysctl.conf
 EOF
 not_if "grep -q net.ipv6 /etc/sysctl.conf"
 notifies :run, 'execute[sysctl]', :immediately
end 

execute "sysctl" do
 user "root"
 command "sysctl -p"
 action :nothing
end

cookbook_file '/usr/lib/systemd/system/jetty.service' do
 source 'jetty.service'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

execute "daemon-reload" do
 user "root"
 command "systemctl daemon-reload"
 action :nothing
end

systemd_unit 'jetty.service' do
 action [ :enable, :start ]
end
