execute "yum-clean-all" do
        command "yum clean all"
        action :run
end

%w{/opt/siloc /opt/siloc/saida/ /opt/siloc/saida/siloc-saida-tabajara-job /opt/siloc/saida/siloc-saida-tabajara-job/config /opt/siloc/saida/siloc-saida-tabajara-job/lib /opt/siloc/saida/siloc-saida-tabajara-job/logs}.each do |dirs|
        directory "#{dirs}" do
                owner "siloc"
                group "siloc"
                mode 0755
                action :create
        end
end

yum_package 'siloc-saida-tabajara-job' do
          allow_downgrade true
          package_name    'siloc-saida-tabajara-job'
          if node.chef_environment == "prod"
           version         node['siloc']['package_version']
          end
          action          [ :upgrade]
          notifies :restart, "service[siloc-saida-tabajara-job]", :delayed
end

if node.chef_environment == "prod"
    systemd_unit 'siloc-saida-tabajara-job.service' do
      content({Unit: {
                Description: 'Siloc-saida-tabajara',
                After: 'syslog.target',
              },
              Service: {
                User: 'siloc',
                WorkingDirectory: '/opt/siloc/saida/siloc-saida-tabajara-job/',
                ExecStart: '/usr/bin/java -server -Xms1536m -Xmx1536m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9024 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/saida/siloc-saida-tabajara-job/lib/siloc-saida-tabajara-job.jar --spring.config.name=siloc-saida-tabajara-job-config --spring.config.location=file:/opt/siloc/saida/siloc-saida-tabajara-job/config/',
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
    systemd_unit 'siloc-saida-tabajara-job.service' do
      content({Unit: {
                Description: 'Siloc-saida-tabajara',
                After: 'syslog.target',
              },
              Service: {
                User: 'siloc',
                WorkingDirectory: '/opt/siloc/saida/siloc-saida-tabajara-job/',
                ExecStart: '/usr/bin/java -server -Xms512m -Xmx512m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9024 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/saida/siloc-saida-tabajara-job/lib/siloc-saida-tabajara-job.jar --spring.config.name=siloc-saida-tabajara-job-config --spring.config.location=file:/opt/siloc/saida/siloc-saida-tabajara-job/config/',
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

service "siloc-saida-tabajara-job" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

template "/opt/siloc/saida/siloc-saida-tabajara-job/config/siloc-saida-tabajara-job-config.yml" do
        owner "siloc"
        group "siloc"
        mode 0644
        source "opt/siloc/saida/siloc-saida-tabajara-job/config/siloc-saida-tabajara-job-config.yml.erb"
        notifies :restart, "service[siloc-saida-tabajara-job]", :delayed
end
