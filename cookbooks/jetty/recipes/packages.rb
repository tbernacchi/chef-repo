#
# Cookbook:: jetty
# Recipe:: java-1.8.0
#
# Copyright:: 2018, The Authors, All Rights Reserved.
yum_package 'java-1.8.0-openjdk.x86_64' do
 action :install
 not_if { File.exist? ("/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64/jre/bin/policytool") }
end

yum_package 'wget' do
 action :install
 not_if { File.exist? ("/bin/wget") }
end
