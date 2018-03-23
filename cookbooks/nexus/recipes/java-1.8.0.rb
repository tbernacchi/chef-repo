#
# Cookbook:: nexus
# Recipe:: java-1.8.0
#
# Copyright:: 2018, The Authors, All Rights Reserved.
bash 'Installing Java' do
 cwd '/opt'
 user 'root'
 code <<-EOF
 wget http://mirror.centos.org/centos/7/updates/x86_64/Packages/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64.rpm
 yum install -y java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64.rpm 
 EOF
 not_if { File.exist? ("/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64/jre/bin/policytool") }
end  

