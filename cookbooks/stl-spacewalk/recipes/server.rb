#
# Cookbook:: stl-spacewalk
# Recipe:: server
#
# Copyright:: 2019, The Authors, All Rights Reserved.
%w{perl-XML-Simple perl-Text-Unidecode perl-Frontier-RPC}.each do |pkg|
 yum_package pkg do
 action :install
 not_if "rpm -q #{pkg}"
 end
end
  
%w{ https://copr-be.cloud.fedoraproject.org/results/@spacewalkproject/spacewalk-2.8/epel-7-x86_64/00736372-spacewalk-repo/spacewalk-repo-2.8-11.el7.centos.noarch.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm }.each do |wget| 
  
file = wget.split('/').last 
  
remote_file "/root/#{file}" do 
 source "#{wget}" 
 owner 'root'
 group 'root'
 mode 0644
 action :create_if_missing
end
  
rpm_package 'Installing repos' do 
 source "/root/#{file}" 
 action :install 
 not_if "rpm -q #{file}" 
 end 
end

cookbook_file '/etc/yum.repos.d/group_spacewalkproject-java-packages-epel-7.repo' do
 source 'yum/group_spacewalkproject-java-packages-epel-7.repo'
 owner 'root'
 group 'root'
 mode '0644'
 action :create_if_missing
end

template "/root/spacewalk-answers.conf" do
 source "spacewalk-answers.conf.erb"
 owner "root"
 group "root"
 mode 0644
end

#execute 'spacewalk-setup' do
# command "/usr/bin/spacewalk-setup --external-oracle --non-interactive --skip-db-diskspace-check --answer-file=/root/spacewalk-answers.conf && touch /var/chef/spacewalk_installed.lock"
# not_if { File.exists?("/var/chef/spacewalk_installed.lock") }
#end

cookbook_file '/etc/spacecmd.conf' do
 source 'etc/spacecmd.conf'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end
 
cookbook_file '/etc/profile.d/spacewalk.sh' do
 source 'etc/spacewalk.sh'
 owner 'root'
 group 'root'
 mode 0644
 action :create_if_missing
end 

cookbook_file "/var/satellite/errata-import.pl" do
 source "var/spacewalk/errata-import.pl"
 owner 'root'
 group 'root'
 mode 0755
 action :create 
end

cookbook_file '/var/satellite/errata_latest.sh' do
 source 'var/spacewalk/errata_latest.sh'
 owner 'root'
 group 'root'
 mode 0644
 action :create_if_missing
end

cookbook_file '/var/satellite/check_errata.sh' do
 source 'var/spacewalk/check_errata.sh'
 owner 'root'
 group 'root'
 mode 0644
 action :create_if_missing
end


#cron "clear DB jabber" do
# hour '06'
# minute '00'
# command '/sbin/service jabberd stop && /sbin/service osa-dispatcher stop && rm -Rf /var/lib/jabberd/db/* && /sbin/service jabberd start && /sbin/service osa-dispatcher start'
#end

%w{jabberd.service tomcat.service spacewalk-wait-for-tomcat.service httpd.service spacewalk-wait-for-jabberd.service osa-dispatcher.service rhn-search.service cobblerd.service taskomatic.service spacewalk.target}.each do |system|
 systemd_unit "#{system}" do 
 action [ :enable, :start ]  
 end 
end 

systemd_unit 'spacewalk.target' do
 action [ :enable, :start ] 
end

