#
# Cookbook:: stl-security
# Recipe:: sshd-infra
#
# Copyright:: 2019, The Authors, All Rights Reserved.
#
# Reinicia o daemon do sshd
execute "daemon-sshd-restart" do
 user "root"
 command "systemctl restart sshd"
 action :nothing
end

bash "insert_line" do
  user "root"
  code <<-EOS
  echo "AllowGroups root sftp infraestrutura_admin" >> /etc/ssh/sshd_config
  EOS
  not_if "grep -q infraestrutura_admin /etc/ssh/sshd_config"
  notifies :run, 'execute[daemon-sshd-restart]', :immediately
end
