#
# Cookbook:: bootstrap
# Recipe:: disable_ipv6
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file '/etc/sysctl.d/100-disable-ipv6.conf' do
  source '100-disable-ipv6.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

execute 'Disable IPv6' do 
 command 'sysctl -p'
 not_if "grep '1' /proc/sys/net/ipv6/conf/ens160/disable_ipv6"
end 
