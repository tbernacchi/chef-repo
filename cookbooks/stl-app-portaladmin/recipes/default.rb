#
# Cookbook:: stl-app-portaladmin
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
if node['fqdn'] == 'hquarteto01.qa.tabajara.intranet'
  execute "yum-clean-all" do
          command "yum clean all"
          action :run
  end
  include_recipe 'stl-app-portaladmin::qa_nginx'
  include_recipe 'stl-app-portaladmin::qa_dxc_merchant'
end

if node['fqdn'] == 'hquarteto02.qa.tabajara.intranet'
  execute "yum-clean-all" do
          command "yum clean all"
          action :run
  end
  include_recipe 'stl-nginx::nginx'
  include_recipe 'stl-app-portaladmin::qa_person'
  include_recipe 'stl-app-portaladmin::qa_authorization'
end

if node['fqdn'] == 'hquarteto03.qa.tabajara.intranet'
  execute "yum-clean-all" do
          command "yum clean all"
          action :run
  end
  include_recipe 'stl-nginx'
  include_recipe 'stl-app-portaladmin::qa_orders'
  include_recipe 'stl-app-portaladmin::qa_chargeback'
  include_recipe 'stl-app-portaladmin::qa_mcartao'
end

if node['fqdn'] == 'hquarteto04.qa.tabajara.intranet'
  execute "yum-clean-all" do
          command "yum clean all"
          action :run
  end
  include_recipe 'stl-nginx'
  include_recipe 'stl-app-portaladmin::qa_fees'
  include_recipe 'stl-app-portaladmin::qa_transaction'
  include_recipe 'stl-app-portaladmin::qa_logistics'
end
