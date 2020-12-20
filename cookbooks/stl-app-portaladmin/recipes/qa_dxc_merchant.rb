include_recipe "stl-nginx"
include_recipe "stl-java"

%w{ /app /app/services /app/services/tabajara-admin-street-dxc-merchant-service-api/ /app/services/tabajara-admin-street-dxc-merchant-service-api/conf /app/services/tabajara-admin-street-dxc-merchant-service-api/logs /app/services/tabajara-admin-street-dxc-merchant-service-api/bin}.each do |dirs|
        directory "#{dirs}" do
                owner "root"
                group "root"
                mode 0755
                action :create
        end
end

systemd_unit 'portaladmin-dxc-merchant-api.service' do
  content({Unit: {
            Description: 'Serviço dxc-merchant API',
            After: 'syslog.target',
            StartLimitIntervalSec: 0,
          },
          Service: {
            Type: 'simple',
            User: 'root',
            WorkingDirectory: '/app/services/tabajara-admin-street-dxc-merchant-service-api/',
            ExecStart: '/usr/bin/java -Xms128m -Xmx128m -jar /app/services/tabajara-admin-street-dxc-merchant-service-api/bin/tabajara-admin-street-dxc-merchant-service-api-1.0.1.jar --spring.config.location=/app/services/tabajara-admin-street-dxc-merchant-service-api/conf/application-hml.properties',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            Restart: 'always',
            SuccessExitStatus: '143',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [ :create ]
end

service "portaladmin-dxc-merchant-api" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [ :enable ]
end

template "/app/services/tabajara-admin-street-dxc-merchant-service-api/conf/application-hml.properties" do
        owner "root"
        group "root"
        mode 0644
        source "app/services/tabajara-admin-street-dxc-merchant-service-api/conf/qa_dmerchant_application_properties.erb"
        notifies :restart, "service[portaladmin-dxc-merchant-api]", :delayed
end
