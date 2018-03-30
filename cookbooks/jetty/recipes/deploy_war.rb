#
# Cookbook:: jetty
# Recipe:: deploy_war
#
# Copyright:: 2018, The Authors, All Rights Reserved.
cookbook_file "/opt/jetty/webapps/java-chef-test.war" do 
  source 'java-chef-test.war' 
  owner 'root'
  group 'root'
  mode 0664
  action :create
  not_if { File.exist? ('/opt/jetty/webapps/java-chef-test.war') }
end

bash 'Rename java-chef-test.war file' do
cwd '/opt/jetty/webapps'
code <<-EOF
mv java-chef-test.war java-artifact-chef-test.war
EOF
not_if { File.exist? ("/opt/jetty/webapps/java-artifact-chef-test.war") }
end