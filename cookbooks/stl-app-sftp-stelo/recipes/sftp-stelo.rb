#
# Cookbook:: stl-app-sftp-tabajara
# Recipe:: sftp-tabajara
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Ponto de montagem
  execute "glusterfs-to-fstab" do
  command "echo 'glusterfs.tabajara.intranet:/volume-sftp   /SFTP  glusterfs defaults,_netdev 0 0' >> /etc/fstab"
  action :run
  not_if "grep -q SFTP /etc/fstab"
end

mount "/SFTP" do
  device "glusterfs.tabajara.intranet:/volume-sftp"
  fstype "glusterfs"
  options "defaults,_netdev"
  notifies :run, "execute[glusterfs-to-fstab]", :immediately
end

cookbook_file '/usr/local/bin/cria-sftp-users.sh' do
  source 'bin/cria-sftp-users.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# ssh include for new users
%w{ ingenico financeiro ingenico bbrasil }.each do |sftpuser|
  execute "#{sftpuser}" do
    command "sh /usr/local/bin/cria-sftp-users.sh add  #{sftpuser}"
    not_if "grep -F #{sftpuser} /etc/ssh/sshd_config"
  end
end
