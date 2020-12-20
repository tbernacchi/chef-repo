#
# Cookbook:: stl-siloc
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
node.default['stl']['ldap']['groupsearchbase'] = 'OU=SILOC,OU=Acesso_Sistemas,OU=Grupos,DC=tabajara,DC=corp'

%w{hfagulha01.qa.tabajara.intranet hfagulha02.qa.tabajara.intranet hquadrante02.qa.tabajara.intranet}.each do |srv|
   if node['fqdn'] == srv
    mount '/opt/silocarquivos/' do
      device 'hquadrante01.qa.tabajara.intranet:/opt/silocarquivos'
      fstype 'nfs'
      options 'rw'
      action [:mount, :enable]
     end
   end
end

%w{quadrado01.tabajara.intranet quadrado02.tabajara.intranet quadrado03.tabajara.intranet quadrado04.tabajara.intranet VINTWS001.tabajaradc.local firula01.tabajara.intranet firula02.tabajara.intranet}.each do |srv|
   if node['fqdn'] == srv
   yum_package 'glusterfs-client' do
      action :install
      not_if { File.exist? ("/usr/lib64/glusterfs/3.12.2/xlator/protocol/client.so") }
   end

   service "rsyslog" do
     supports :start => true, :stop => true, :restart => true, :status => true
     action [:enable, :start]
   end

   directory "/opt/silocarquivos" do
     owner "root"
     group "root"
     mode 0755
     action :create
   end

   template "/etc/rsyslog.d/graylog.conf" do
     owner "root"
     group "root"
     mode 0644
     source "etc/rsyslog.d/graylog.conf.erb"
     notifies :restart, "service[rsyslog]", :delayed
   end

   mount "/opt/silocarquivos" do
    device "glusterfs.tabajara.intranet:/volume-cip"
    fstype "glusterfs"
    options "defaults,_netdev"
    action [:mount, :enable]
   end
 end
end

%w{hfagulha01.qa.tabajara.intranet hfagulha02.qa.tabajara.intranet}.each do |web|
  if node['fqdn'] == web
    include_recipe 'stl-java'
    include_recipe 'stl-nginx'
    include_recipe 'stl-app-siloc::webportal'
  end
end

%w{firula01.tabajara.intranet firula02.tabajara.intranet}.each do |web|
  if node['fqdn'] == web
    include_recipe 'stl-java'
    include_recipe 'stl-nginx'
    include_recipe 'stl-app-siloc::webportal'
  end
end

  if node['fqdn'] == 'quadrado01.tabajara.intranet'
    include_recipe 'stl-app-siloc::entrada_cip'
    include_recipe 'stl-app-siloc::entrada_tabajara'
  end

  if node['fqdn'] == 'quadrado02.tabajara.intranet'
    include_recipe 'stl-app-siloc::saida_cip'
    include_recipe 'stl-app-siloc::saida_tabajara'
  end

  if node['fqdn'] == 'quadrado03.tabajara.intranet'
    include_recipe 'stl-app-siloc::credenciamento'
    include_recipe 'stl-app-siloc::processamento_xml'
  end

if node['fqdn'] == 'hquadrante01.qa.tabajara.intranet'
  cookbook_file '/opt/silocarquivos/scripts/deploy.sh' do
   source 'opt/silocarquivos/scripts/deploy.sh'
   owner 'dfin'
   group 'dfin'
   mode '0755'
   action :create
   not_if { File.exist? ("/opt/silocarquivos/scripts/deploy.sh") }
  end
  include_recipe 'stl-java'
  include_recipe 'stl-app-siloc::entrada_tabajara'
  include_recipe 'stl-app-siloc::saida_cip'
  include_recipe 'stl-app-siloc::saida_tabajara'
end

if node['fqdn'] == 'hquadrante02.qa.tabajara.intranet'
  include_recipe 'stl-java'
  include_recipe 'stl-app-siloc::entrada_cip'
  include_recipe 'stl-app-siloc::processamento_xml'
  include_recipe 'stl-app-siloc::conciliacao'
end

if node['fqdn'] == 'quadrado04.tabajara.intranet'
  include_recipe 'stl-app-siloc::conciliacao'
end
