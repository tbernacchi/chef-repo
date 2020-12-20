#
# Cookbook:: stl-prometheus
# Recipe:: net-scp
#
# Copyright:: 2019, The Authors, All Rights Reserved.
# require 'net/scp'
# 
# Net::SCP.download!("zaster01.tabajara.intranet", "root",
#   "/etc/kubernetes/admin.conf", "/opt/kubernetes/admin.conf",
#   :ssh => { :password => "123456" })

secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret/secret-file") 
passwords = Chef::EncryptedDataBagItem.load("prometheus","root", secret) 

bash "Teste de data bag" do 
  user 'root'
  code <<-EOF
  echo "Teste de data bag, o usuario eh => #{passwords['username']}" > /tmp/teste_data_bag 
  EOF
end
