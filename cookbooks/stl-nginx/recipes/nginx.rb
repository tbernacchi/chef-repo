yum_package 'nginx' do
	allow_downgrade	true
	package_name	'nginx'
	version		'1.13.10-1.el7_4.ngx'
	action		[ :install]
	not_if 		"test -d /usr/sbin/nginx"
end

template "/etc/nginx/nginx.conf" do
        owner "root"
        group "root"
        mode 0644
        source "nginx.conf.erb"
        notifies :restart, "service[nginx]", :delayed
end

service "nginx" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

