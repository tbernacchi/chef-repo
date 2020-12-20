#
# Cookbook:: stl-app-redis
# Recipe:: app-redis.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# install redis package
yum_package 'redis' do
        allow_downgrade true
        package_name    'redis'
        version         '5.0.2-1.el7.remi'
        action          [ :install]
        not_if          "test -f /usr/bin/redis-server"
end

# make directory
directory "/etc/redis" do
    action :create
    recursive true
    owner "redis"
    group "root"
    mode 0755
    action :create
end

# conf
# redis dameon file
cookbook_file '/etc/redis.conf' do
  source 'etc/redis.conf'
  owner 'redis'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, "service[redis]", :delayed
end

# Howto - Create de cluster file for redis
# redis-cli --cluster create 10.150.230.20:6379 10.150.230.21:6379 10.150.230.40:6379  10.150.230.60:6379 10.150.230.47:6379 10.150.230.48:6379 --cluster-replicas 1
# Este arquivo nao deve ser alterado manualmente
## Cluster file to cluster redis in your environment
# QA
#if node.chef_environment == 'qa'
#	cookbook_file '/etc/redis/cluster-node.conf' do
#	source 'etc/redis/cluster-qa-node.conf'
#	owner 'redis'
#	group 'root'
#	mode '0444'
#	action :create
#	notifies :restart, "service[redis]", :delayed
#   end
#end

# PROD
#if node.chef_environment == 'prod'
#	cookbook_file '/etc/redis/cluster-node.conf' do
#	source 'etc/redis/cluster-prod-node.conf'
#	owner 'redis'
#	group 'root'
#	mode '0444'
#	action :create
#	notifies :restart, "service[redis]", :delayed
#   end
#end

# the service
service "redis" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

# kernel params
# kernel
cookbook_file '/etc/sysctl.d/100-redis.conf' do
        source 'etc/sysctl.d/100-redis.conf'
        owner 'root'
        group 'root'
        mode 0755
        action :create
        notifies :run, 'execute[sysctl-load]', :immediately
end

 execute 'sysctl-load' do
    command 'sysctl -p etc/sysctl.d/100-redis.conf'
    command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
    action :nothing
end

 # Entrega do script para a criacao do cluster em caso de crash
 cookbook_file '/usr/local/bin/make-redis.sh' do
   source 'bin/make-redis.sh'
   owner 'root'
   group 'root'
   mode 0755
   action :create
end

