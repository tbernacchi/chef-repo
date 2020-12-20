#
# Cookbook:: stl-institucional
# Recipe:: sftp-imagens.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.
directory "/usr/local/bin/rotinas-sftp" do
 action :create
 recursive true
 owner "nobody"
 group "nobody"
 mode 0644
end

package %w(glusterfs-fuse rsync) do
 action :install
end

directory "/SFTP-site-inst" do
 owner "root"
 group "root"
 action :create
 recursive true
 mode 0644
end

execute "glusterfs-to-fstab" do
 command "echo 'glusterfs.tabajara.intranet:/volume-site-institucional   /SFTP-site-inst   glusterfs defaults,_netdev 0 0' >> /etc/fstab"
 action :run
 not_if "grep -q SFTP-site-inst /etc/fstab"
end

mount "/SFTP-site-inst" do
 device "glusterfs.tabajara.intranet:/volume-site-institucional"
 stype "glusterfs"
 options "defaults,_netdev"
 notifies :run, "execute[glusterfs-to-fstab]", :immediately
end

directory "/SFTP-site-inst/imagens-admin/imagens-admin" do
 owner "root"
 group "root"
 action :create
 recursive true
 mode 0755
end
