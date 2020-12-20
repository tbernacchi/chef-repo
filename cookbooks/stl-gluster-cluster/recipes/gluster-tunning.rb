#
# Cookbook:: stl-gluster-cluster
# Recipe:: gluster-tunning
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
# http://knowledgebase.45drives.com/kb/gluster-performance-tuning/
cookbook_file '/etc/sysctl.d/100-gluster.conf' do
        source 'etc/sysctl.d/100-gluster.conf'
        owner 'root'
        group 'root'
        mode 0755
        action :create
        notifies :run, 'execute[sysctl-load]', :immediately
end

execute 'sysctl-load' do
    command 'sysctl -p etc/sysctl.d/100-gluster.conf'
    action :nothing
end
