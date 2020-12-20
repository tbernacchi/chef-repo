execute "yum-clean-all" do
        command "yum clean all"
        action :run
end

%w{/opt/siloc /opt/siloc/entrada/ /opt/siloc/entrada/siloc-entrada-cip-job /opt/siloc/entrada/siloc-entrada-cip-job/config /opt/siloc/entrada/siloc-entrada-cip-job/lib /opt/siloc/entrada/siloc-entrada-cip-job/logs}.each do |dirs|
    directory "#{dirs}" do
        owner "siloc"
        group "siloc"
        mode 0755
        action :create
    end
end

yum_package 'siloc-entrada-cip-job' do
          allow_downgrade true
          package_name    'siloc-entrada-cip-job'
          if node.chef_environment == "prod"
           version         node['siloc']['applications'][node.chef_environment]['version']
          end
          action          [ :upgrade]
          notifies :restart, "service[siloc-entrada-cip-job]", :delayed
end

systemd_unit 'siloc-entrada-cip-job.service' do
  content({Unit: {
            Description: 'Siloc-entrada-cip',
            After: 'syslog.target',
          },
          Service: {
            User: 'siloc',
            WorkingDirectory: '/opt/siloc/entrada/siloc-entrada-cip-job/',
            ExecStart: '/usr/bin/java -server -Xms1024m -Xmx1024m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9040 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/entrada/siloc-entrada-cip-job/lib/siloc-entrada-cip-job.jar --spring.config.name=siloc-entrada-cip-job-config --spring.config.location=file:/opt/siloc/entrada/siloc-entrada-cip-job/config/',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            Restart: 'always',
            SuccessExitStatus: '143',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [ :create ]
end

service "siloc-entrada-cip-job" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
end

template "/opt/siloc/entrada/siloc-entrada-cip-job/config/siloc-entrada-cip-job-config.yml" do
        owner "siloc"
        group "siloc"
        mode 0644
        source "opt/siloc/entrada/siloc-entrada-cip-job/config/siloc-entrada-cip-job-config.yml.erb"
        notifies :restart, "service[siloc-entrada-cip-job]", :delayed
end
