#
# Cookbook:: stl-sftp-produtos
# Recipe:: stl-sftp-produtos.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Cria o diretorio
directory "/usr/local/bin/rotinas-sftp" do
    action :create
    recursive true
    owner "nobody"
    group "nobody"
    mode 0644
    action :create
end

# Reinicia o daemon do sshd
execute "daemon-sshd-restart" do
 user "root"
 command "systemctl restart sshd"
 action :nothing
end

# Instalando o pacote cliente do glusterfs
package %w(glusterfs-fuse rsync) do
  action :install
end

# Ponto de montagem
execute "glusterfs-to-fstab" do
        command "echo 'glusterfs.tabajara.intranet:/volume-sftp-produtos   /SFTP-produtos   glusterfs defaults,_netdev 0 0' >> /etc/fstab"
        action :run
        not_if "grep -q SFTP-produtos /etc/fstab"
end

# Cria o diretorio
directory "/SFTP-produtos" do
    action :create
    recursive true
    owner "root"
    group "root"
    mode 0644
    action :create
end

mount "/SFTP-produtos" do
        device "glusterfs.tabajara.intranet:/volume-sftp-produtos"
        fstype "glusterfs"
        options "defaults,_netdev"
        notifies :run, "execute[glusterfs-to-fstab]", :immediately
end
