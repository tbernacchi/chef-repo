#
# Cookbook:: stl-kubernetes
# Recipe:: route-to-hp
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#

# reload iface file
execute "iface-load" do
  command 'ifup ens160'
  action :nothing
end

# Route file: environment check
if node.chef_environment == 'prod'
       cookbook_file '/etc/sysconfig/network-scripts/route-ens160' do
       source 'etc/sysconfig/network-scripts/prod-route-ens160'
       owner 'root'
       group 'root'
       mode '0644'
       action :create
       notifies :run, 'execute[iface-load]', :immediately
   end
end

if node.chef_environment == 'qa'
       cookbook_file '/etc/sysconfig/network-scripts/route-ens160' do
       source 'etc/sysconfig/network-scripts/qa-route-ens160'
       owner 'root'
       group 'root'
       mode '0644'
       action :create
       notifies :run, 'execute[iface-load]', :immediately
   end
end
