#
# Cookbook:: stl-security
# Recipe:: passwd
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# To use this recipe you should first to create sha-512 cryptographic hash 
# i.e -> openssl passwd -1 "tabajara123" 
user 'root' do
 comment 'root'
 uid '0'
 home '/root'
 shell '/bin/bash'
 password '$1$tEtQHhgn$QVQ4VGFpOuS7koI5PKZ2U0'
end
