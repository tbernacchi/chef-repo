include_recipe "stl-nginx"
include_recipe "stl-java"

%w{ /app /app/services /app/services/tabajara-admin-street-logistics-service-api/ /app/services/tabajara-admin-street-logistics-service-api/conf /app/services/tabajara-admin-street-logistics-service-api/logs /app/services/tabajara-admin-street-logistics-service-api/bin}.each do |dirs|
        directory "#{dirs}" do
                owner "root"
                group "root"
                mode 0755
                action :create
        end
end

systemd_unit 'portaladmin-logistics-api.service' do
  content({Unit: {
            Description: 'Serviço logistics API',
            After: 'syslog.target',
            StartLimitIntervalSec: 0,
          },
          Service: {
            Type: 'simple',
            User: 'root',
            WorkingDirectory: '/app/services/tabajara-admin-street-logistics-service-api/',
            ExecStart: '/usr/bin/java -Xms256m -Xmx256m -jar /app/services/tabajara-admin-street-logistics-service-api/bin/tabajara-admin-street-logistics-service-api-1.0.1.jar --spring.config.location=/app/services/tabajara-admin-street-logistics-service-api/conf/application-hml.properties',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            Restart: 'always',
            SuccessExitStatus: '143',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [ :create ]
end

service "portaladmin-logistics-api" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
end

template "/app/services/tabajara-admin-street-logistics-service-api/conf/application-hml.properties" do
        owner "root"
        group "root"
        mode 0644
        source "app/services/tabajara-admin-street-logistics-service-api/conf/qa_logistics_application_properties.erb"
        notifies :restart, "service[portaladmin-logistics-api]", :delayed
end

template "/app/services/tabajara-admin-street-logistics-service-api/conf/log4j2-hml.xml" do
        owner "root"
        group "root"
        mode 0644
        source "app/services/tabajara-admin-street-logistics-service-api/conf/qa_logistics_log4j2.xml.erb"
        notifies :restart, "service[portaladmin-logistics-api]", :delayed
end
