#
# Cookbook:: stl-pentaho-di
# Recipe:: kettle
#
# Copyright:: 2019, The Authors, All Rights Reserved.

yum_package 'unzip' do
        allow_downgrade true
        package_name    'unzip'
#        version         '5.0.2-1.el7.remi'
        action          [ :install]
        not_if          "test -f /usr/bin/unzip"
end


# make directory
directory "/opt/data-integration" do
    action :create
    recursive true
    owner "svc_kettle"
    group "domain users"
    mode 0755
    action :create
end

remote_file "/tmp/pdi-ce-7.1.0.0-12.zip" do
if node.chef_environment == "qa"
  source "http://repo.qa.tabajara.intranet/pacotes/pentaho-di/pdi-ce-7.1.0.0-12.zip"
end
if node.chef_environment == "prod"
  source "http://repo.tabajara.intranet/pacotes/pentaho-di/pdi-ce-7.1.0.0-12.zip"
end
#  checksum "ab83be..."
  mode 0644
  action :create_if_missing
end

#zabbix trapper plugin
remote_file "/tmp/zabbix-trapper-plugin.zip" do
if node.chef_environment == "qa"
  source "http://repo.qa.tabajara.intranet/pacotes/zabbix/zabbix-trapper-plugin/zabbix-trapper-plugin.zip"
end
if node.chef_environment == "prod"
  source "http://repo.tabajara.intranet/pacotes/zabbix/zabbix-trapper-plugin/zabbix-trapper-plugin.zip"
end

#  checksum "ab83be..."
  mode 0644
  action :create_if_missing
end


# install pentaho-di

bash 'install_kettle' do
  user 'svc_kettle'
  group 'domain users'
  cwd '/tmp'
  code <<-EOH
  cd /opt/
  unzip -o /tmp/pdi-ce-7.1.0.0-12.zip
  EOH
  not_if { ::File.exist?('/opt/data-integration/spoon.sh') }
end
 

# copia arquivos
#
remote_file "/opt/data-integration/lib/ojdbc6.jar" do
if node.chef_environment == "qa"
  source "http://repo.qa.tabajara.intranet/repos/oracle/ojdbc6.jar" 
end
if node.chef_environment == "prod"
  source "http://repo.tabajara.intranet/repos/oracle/ojdbc6.jar"  
end

#  checksum "ab83be..."
  mode 0644
  owner 'svc_kettle'
  group 'domain users'
  action :create_if_missing
end

# unzip zabbix plugin
bash 'install_zabbix_plugin' do
  user 'svc_kettle'
  group 'domain users'
  cwd '/tmp'
  code <<-EOH
  cd /opt/data-integration/plugins
  unzip -o /tmp/zabbix-trapper-plugin.zip  
  EOH
  not_if { ::Dir.exist?('/opt/data-integration/plugins/zabbix-trapper-plugin') }
end


# Remove arquivos não utilizados do pdi para aumentar a performance de inicializacao
#bash 'capa_kettle' do
#  user 'root'
#  group 'root'
#  cwd '/tmp'
#  code <<-EOH
#rm -R 	/opt/data-integration/classes/kettle-lifecycle-listeners.xml \
#		/opt/data-integration/classes/kettle-registry-extensions.xml \
#		/opt/data-integration/classes/log4j.xml \
#		/opt/data-integration/lib/pdi-engine-api-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pdi-engine-spark-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pdi-osgi-bridge-core-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pdi-spark-driver-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-capability-manager-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-connections-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-cwm-1.5.4.jar \
#		/opt/data-integration/lib/pentaho-database-model-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-hadoop-shims-api-80.2017.10.00-28.jar \
#		/opt/data-integration/lib/pentaho-metaverse-api-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-osgi-utils-api-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-platform-api-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-platform-core-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-platform-extensions-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-platform-repository-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-registry-8.0.0.0-28.jar \
#		/opt/data-integration/lib/pentaho-service-coordinator-8.0.0.0-28.jar \
#		/opt/data-integration/plugins/kettle5-log4j-plugin \
#		/opt/data-integration/plugins/pentaho-big-data-plugin \
#		/opt/data-integration/system/*
#  EOH
#  ignore_failure true
#  only_if { ::Dir.exist?('/opt/data-integration/system/osgi') }
#end
