#
# Cookbook Name:	inline-iptables
# Recipe: 		default
# Author:		Alex D Glover (alex@alexdglover.com)
# Description:		A recipe to manage iptables without impacting existing 
#			iptables rules or chains, and allowing individual
#			inbound/outbound ports as well as port ranges to be 
#			managed with programmatic ease.
# Dependencies:		attributes/default.rb
# Usage:		Set the ["inline-iptables"]["listen_ports"] and/or
#			["inline-iptables"]["outbound_ports"] attributes at the
#			node or role level
## Save first iptables rule
execute "saving first rules" do
 command "/usr/sbin/iptables-save > /etc/sysconfig/iptables"
end

### Lock yum install 
#execute "yum-clean-all" do
# command "touch /tmp/yum.lock && yum clean all"
# action :run
# not_if { File.exists? ("/tmp/yum.lock") }
#end 
#
### Remove firewalld
#['firewalld', 'firewalld-filesystem'].each do |fir|
# yum_package fir do
# action :remove
# only_if "rpm -q #{fir}"
# end
#end
#
### Install iptables
#['iptables', 'iptables-services'].each do |ipt|
# yum_package ipt do
# action :install
# not_if "rpm -q #{ipt}"
# end
#end
#
### Enable start iptables
#systemd_unit "iptables" do
# action [ :enable, :start ] 
#end
#
### Keep in mind these attribute could be set by a role, recipe, or node override
#source_address      = node["inline-iptables"]["source_address"]
#dest_address  	    = node["inline-iptables"]["dest_address"]
#dest_port      	    = node["inline-iptables"]["dest_port"]
#
### Boolean variable to track if we a change has been made
#iptables_modified = false
#
#### Debug friendly logging
#Chef::Log.info <<-EOS
#Entering ondemand_base::iptables_manager {
#   source_address     = #{source_address}
#   dest_address       = #{dest_address}
#   dest_port	     = #{dest_port}
#}
#EOS
#
### Create and save firewall rules
#execute "saving firewall rules checking port #{dest_port}" do
# command "/usr/sbin/iptables-save > /etc/sysconfig/iptables"
# not_if "iptables -L | grep -q websm"
#end
#
### Read the current iptables data
#iptables_content = File.read("/etc/sysconfig/iptables")
#
### We are creating a new iptables chain if it already exists, don't create.
#if not iptables_content.include?("9090")
#   execute "Add prometheus chain" do
#   command "iptables -I INPUT -p tcp -s #{source_address} -d #{dest_address} --dport #{dest_port} -j REJECT --reject-with tcp-reset"
#   notifies :restart, 'systemd_unit[iptables]', :immediately
#  end
#  iptables_modified = true
#end
# 
#if iptables_modified
#  
#execute "save updated iptables with port #{dest_port}" do
# command "/usr/sbin/iptables-save > /etc/sysconfig/iptables"
#end
#
#systemd_unit "iptables" do
# action :restart
# ignore_failure true
# end
#else
# Chef::Log.info "No changes made, not restarting iptables"
#end
