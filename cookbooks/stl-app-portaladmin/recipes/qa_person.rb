include_recipe "stl-nginx"
include_recipe "stl-java"

%w{ /app /app/services /app/services/tabajara-admin-street-person-service-api/ /app/services/tabajara-admin-street-person-service-api/conf /app/services/tabajara-admin-street-person-service-api/logs /app/services/tabajara-admin-street-person-service-api/bin}.each do |dirs|
        directory "#{dirs}" do
                owner "root"
                group "root"
                mode 0755
                action :create
        end
end

systemd_unit 'portaladmin-person-api.service' do
  content({Unit: {
            Description: 'Serviço Person API',
            After: 'syslog.target',
            StartLimitIntervalSec: 0,
          },
          Service: {
            Type: 'simple',
            User: 'root',
            WorkingDirectory: '/app/services/tabajara-admin-street-person-service-api/',
            ExecStart: '/usr/bin/java -Xms512m -Xmx512m -jar /app/services/tabajara-admin-street-person-service-api/bin/tabajara-admin-street-person-service-api-1.0.1.jar --spring.config.location=/app/services/tabajara-admin-street-person-service-api/conf/application-hml.properties',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            Restart: 'always',
            SuccessExitStatus: '143',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [ :create ]
end

service "portaladmin-person-api" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
end

template "/app/services/tabajara-admin-street-person-service-api/conf/application-hml.properties" do
        owner "root"
        group "root"
        mode 0644
        source "app/services/tabajara-admin-street-person-service-api/conf/qa_person_application_properties.erb"
        notifies :restart, "service[portaladmin-person-api]", :delayed
end

template "/app/services/tabajara-admin-street-person-service-api/conf/log4j2-hml.xml" do
        owner "root"
        group "root"
        mode 0644
        source "app/services/tabajara-admin-street-person-service-api/conf/qa_person_log4j2.xml.erb"
        notifies :restart, "service[portaladmin-person-api]", :delayed
end

cookbook_file '/etc/nginx/conf.d/person.conf' do
  source 'qa_person.conf'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, "service[nginx]", :delayed
end
