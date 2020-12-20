include_recipe 'stl-ldap'

execute "yum-clean-all" do
        command "yum clean all"
        action :run
end

%w{/opt/siloc /opt/siloc/web /opt/siloc/web/siloc-web-portal /opt/siloc/web/siloc-web-portal/config /opt/siloc/web/siloc-web-portal/lib /opt/siloc/web/siloc-web-portal/logs}.each do |dirs|
        directory "#{dirs}" do
                owner "siloc"
                group "siloc"
                mode 0755
                action :create
        end
end

yum_package 'dfin-web-portal' do
          allow_downgrade true
          package_name    'dfin-web-portal'
          if node.chef_environment == "prod"
           version         node['siloc']['applications'][node.chef_environment]['version']
          end
          action          [ :upgrade ]
          notifies :restart, "service[siloc-web-portal]", :delayed
end

service "nginx" do
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [ :start, :enable ]
end

template "/etc/nginx/conf.d/siloc.conf" do
  source "etc/nginx/conf.d/siloc.conf.erb"
  notifies :restart, "service[nginx]", :delayed
end

if node.chef_environment == "prod"
  systemd_unit 'siloc-web-portal.service' do
    content({Unit: {
              Description: 'Siloc-web-portal',
              After: 'syslog.target',
            },
            Service: {
              User: 'siloc',
              WorkingDirectory: '/opt/siloc/web/siloc-web-portal',
              ExecStart: '/usr/bin/java -server -Xms1536m -Xmx1536m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote.port=9011 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/web/siloc-web-portal/lib/siloc-web-portal.war --spring.config.name=siloc-web-portal-config --spring.config.location=file:/opt/siloc/web/siloc-web-portal/config/',
  	          ExecStop: '/bin/kill -s TERM $MAINPID',
              Restart: 'always',
              SuccessExitStatus: '143',
            },
            Install: {
              WantedBy: 'multi-user.target',
            }})
    action [:create]
  end
end

if node.chef_environment == "qa"
  systemd_unit 'siloc-web-portal.service' do
    content({Unit: {
              Description: 'Siloc-web-portal',
              After: 'syslog.target',
            },
            Service: {
              User: 'siloc',
              WorkingDirectory: '/opt/siloc/web/siloc-web-portal',
              ExecStart: '/usr/bin/java -server -Xms256m -Xmx256m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Djava.rmi.server.hostname=localhost -Dcom.sun.management.jmxremote.port=9011 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/web/siloc-web-portal/lib/siloc-web-portal.war --spring.config.name=siloc-web-portal-config --spring.config.location=file:/opt/siloc/web/siloc-web-portal/config/',
  	          ExecStop: '/bin/kill -s TERM $MAINPID',
              Restart: 'always',
              SuccessExitStatus: '143',
            },
            Install: {
              WantedBy: 'multi-user.target',
            }})
    action [:create]
  end
end

service "siloc-web-portal" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

template "/opt/siloc/web/siloc-web-portal/config/siloc-web-portal-config.yml" do
        owner "siloc"
        group "siloc"
        mode 0644
        source "opt/siloc/web/siloc-web-portal/config/siloc-web-portal-config.yml.erb"
        notifies :restart, "service[siloc-web-portal]", :delayed
end
