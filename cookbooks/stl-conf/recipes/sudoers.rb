# add sudoers (default) and include files
cookbook_file '/etc/sudoers' do
 source 'etc/sudoers'
 owner 'root'
 group 'root'
 mode '0440'
 action :create
end

cookbook_file '/etc/sudoers.d/dev-users' do
  source 'etc/sudoers.d/dev-users'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end

cookbook_file '/etc/sudoers.d/implantacao-users' do
  source 'etc/sudoers.d/implantacao-users'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end

cookbook_file '/etc/sudoers.d/infra-users' do
  source 'etc/sudoers.d/infra-users'
  owner 'root'
  group 'root'
  mode '0400'
  action :create
end


