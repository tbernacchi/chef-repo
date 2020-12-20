#
# Cookbook:: stl-spacewalk
# Recipe:: setup
#
# Copyright:: 2019, The Authors, All Rights Reserved.
execute 'spacewalk-setup' do
  command "/usr/bin/spacewalk-setup --external-oracle --non-interactive --skip-db-diskspace-check --answer-file=/root/spacewalk-answers.conf && touch /var/chef/spacewalk_installed.lock"
  not_if { File.exists?("/var/chef/spacewalk_installed.lock") }
end
