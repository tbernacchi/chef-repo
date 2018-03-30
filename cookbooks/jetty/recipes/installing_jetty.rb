#
# Cookbook:: jetty
# Recipe:: installing_jetty
# Copyright:: 2018, The Authors, All Rights Reserved.
remote_file '/opt/jetty-distribution-9.4.9.v20180320.tar.gz' do 
 source 'http://central.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.9.v20180320/jetty-distribution-9.4.9.v20180320.tar.gz'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/opt/jetty-distribution-9.4.9.v20180320.tar.gz") }  
end

bash 'Installing jetty' do
 cwd '/opt'
 user 'root'
 code <<-EOF
 /bin/tar -zxvf jetty-distribution-9.4.9.v20180320.tar.gz
 mv  jetty-distribution-9.4.9.v20180320 jetty/
 chown -R jetty:jetty jetty/
 EOF
 #not_if { File.exist? ("/opt/jetty-distribution-9.4.9.v20180320.tar.gz") }  
end

template '/etc/default/jetty' do
 source 'jetty.default.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

template '/opt/jetty/start.ini' do
 source 'start.ini.erb'
 owner 'jetty'
 group 'jetty'
 mode '0644'
 action :create
end

bash 'Removing webapps files' do
cwd '/opt/jetty/webapps'
code <<-EOF
rm -rf *
EOF
not_if { File.exist? ("/opt/jetty/webapps/java-artifact-chef-test.war") }
end

bash 'Moving jetty-distribution-9.4.9.v20180320.tar.gz' do
 cwd '/opt'
 code <<-EOF
 mv jetty-distribution-9.4.9.v20180320.tar.gz /root/
 EOF
not_if { File.exist? ("/root/jetty-distribution-9.4.9.v20180320.tar.gz") }
end

#bash 'Permission on /var/run/jetty' do
#code <<-EOF
#chown -R jetty:jetty /var/run/jetty 
#EOF
#end

