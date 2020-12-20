execute "yum-clean-all" do
        command "yum clean all"
        action :run
end

%w{/opt/siloc /opt/siloc/entrada/ /opt/siloc/entrada/siloc-entrada-tabajara-job /opt/siloc/entrada/siloc-entrada-tabajara-job/config /opt/siloc/entrada/siloc-entrada-tabajara-job/lib /opt/siloc/entrada/siloc-entrada-tabajara-job/logs}.each do |dirs|
        directory "#{dirs}" do
                owner "siloc"
                group "siloc"
                mode 0755
                action :create
        end
end

yum_package 'siloc-entrada-tabajara-job' do
          allow_downgrade true
          package_name    'siloc-entrada-tabajara-job'
          if node.chef_environment == "prod"
           version         node['siloc']['applications'][node.chef_environment]['version']
          end
          action          [ :upgrade]
          notifies :restart, "service[siloc-entrada-tabajara-job]", :delayed
end

systemd_unit 'siloc-entrada-tabajara-job.service' do
  content({Unit: {
            Description: 'Siloc-entrada-tabajara',
            After: 'syslog.target',
          },
          Service: {
            User: 'siloc',
            WorkingDirectory: '/opt/siloc/entrada/siloc-entrada-tabajara-job/',
            ExecStart: '/usr/bin/java -server -Xms1024m -Xmx1024m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9029 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/entrada/siloc-entrada-tabajara-job/lib/siloc-entrada-tabajara-job.jar --spring.config.name=siloc-entrada-tabajara-job-config --spring.config.location=file:/opt/siloc/entrada/siloc-entrada-tabajara-job/config/',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            Restart: 'always',
            SuccessExitStatus: '143',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [:create]
end

service "siloc-entrada-tabajara-job" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

template "/opt/siloc/entrada/siloc-entrada-tabajara-job/config/siloc-entrada-tabajara-job-config.yml" do
        owner "siloc"
        group "siloc"
        mode 0644
        source "opt/siloc/entrada/siloc-entrada-tabajara-job/config/siloc-entrada-tabajara-job-config.yml.erb"
        notifies :restart, "service[siloc-entrada-tabajara-job]", :delayed
end
