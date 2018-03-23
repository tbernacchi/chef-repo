#
# Cookbook:: nexus
# Recipe:: installing_nexus
#
# Copyright:: 2018, The Authors, All Rights Reserved.
# not_if { File.exist?("/opt/nexus-3.7.1-02-unix.tar.gz || /opt/nexus || /opt/sonatype-work") } 
#testar uma condicao para repor os arquivos se forem apagados
remote_file '/opt/nexus-3.7.1-02-unix.tar.gz' do 
 source 'http://download.sonatype.com/nexus/3/nexus-3.7.1-02-unix.tar.gz'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
 not_if { File.exist? ("/root/nexus-3.7.1-02-unix.tar.gz") }  
end

bash 'Installing Nexus' do
 cwd '/opt'
 user 'root'
 code <<-EOF
 tar -zxvf nexus-3.7.1-02-unix.tar.gz
 chown -R nexus:nexus nexus-3.7.1-02/
 chown -R nexus:nexus sonatype-work/
 EOF
 not_if { File.exist? ("/root/nexus-3.7.1-02-unix.tar.gz") }  
end

file '/opt/nexus-3.7.1-02/bin/nexus.rc' do
content 'run_as_user="nexus"'
 mode '0644'
 owner 'nexus'
 group 'nexus'
end

template '/opt/sonatype-work/nexus3/etc/nexus.properties' do
 source 'nexus.properties.erb'
 owner 'nexus'
 group 'nexus'
 mode '0644'
 action :create
end

template '/opt/nexus-3.7.1-02/bin/nexus' do
 source 'nexus.erb'
 owner 'nexus'
 group 'nexus'
 mode '0755'
 action :create
end

bash 'Moving Nexus.tar.gz' do
 cwd '/opt'
 code <<-EOF
 mv nexus-3.7.1-02-unix.tar.gz /root/
 EOF
 not_if { File.exist? ("/root/nexus-3.7.1-02-unix.tar.gz") }
end

