include_recipe "stl-nginx::nginx"

template "/etc/nginx/nginx.conf" do
        owner "root"
        group "root"
        mode 0644
        source "etc/nginx/nginx.conf.erb"
        notifies :restart, "service[nginx]", :delayed
end

template "/etc/nginx/conf.d/portaladmin.conf" do
        owner "root"
        group "root"
        mode 0644
        source "etc/nginx/conf.d/qa_portaladmin.erb"
        notifies :restart, "service[nginx]", :delayed
end
