execute "yum-clean-all" do
        command "yum clean all"
        action :run
end

%w{/opt/siloc /opt/siloc/processamento/ /opt/siloc/processamento/siloc-processamento-geracaoxml-job/ /opt/siloc/processamento/siloc-processamento-geracaoxml-job/config /opt/siloc/processamento/siloc-processamento-geracaoxml-job/lib /opt/siloc/processamento/siloc-processamento-geracaoxml-job/logs}.each do |dirs|
        directory "#{dirs}" do
                owner "siloc"
                group "siloc"
                mode 0755
                action :create
        end
end

yum_package 'siloc-processamento-geracaoxml-job' do
          allow_downgrade true
          package_name    'siloc-processamento-geracaoxml-job'
          if node.chef_environment == "prod"
           version         node['siloc']['applications'][node.chef_environment]['version']
          end
          action          [ :upgrade]
          notifies :restart, "service[siloc-processamento-geracaoxml-job]", :delayed
end
if node.chef_environment == "prod"
  systemd_unit 'siloc-processamento-geracaoxml-job.service' do
    content({Unit: {
              Description: 'siloc-processamento-geracaoxml-job',
              After: 'syslog.target',
            },
            Service: {
              User: 'siloc',
              WorkingDirectory: '/opt/siloc/processamento/siloc-processamento-geracaoxml-job/',
              ExecStart: '/usr/bin/java -server -Xms2048m -Xmx2048m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9022 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/processamento/siloc-processamento-geracaoxml-job/lib/siloc-processamento-geracaoxml-job.jar --spring.config.name=siloc-processamento-geracaoxml-job-config --spring.config.location=file:/opt/siloc/processamento/siloc-processamento-geracaoxml-job/config/',
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
  systemd_unit 'siloc-processamento-geracaoxml-job.service' do
    content({Unit: {
              Description: 'siloc-processamento-geracaoxml-job',
              After: 'syslog.target',
            },
            Service: {
              User: 'siloc',
              WorkingDirectory: '/opt/siloc/processamento/siloc-processamento-geracaoxml-job/',
              ExecStart: '/usr/bin/java -server -Xms768m -Xmx768m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9022 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/processamento/siloc-processamento-geracaoxml-job/lib/siloc-processamento-geracaoxml-job.jar --spring.config.name=siloc-processamento-geracaoxml-job-config --spring.config.location=file:/opt/siloc/processamento/siloc-processamento-geracaoxml-job/config/',
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

service "siloc-processamento-geracaoxml-job" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
end

template "/opt/siloc/processamento/siloc-processamento-geracaoxml-job/config/siloc-processamento-geracaoxml-job-config.yml" do
        owner "siloc"
        group "siloc"
        mode 0644
        source "opt/siloc/processamento/siloc-processamento-geracaoxml-job/config/siloc-processamento-geracaoxml-job-config.yml.erb"
        notifies :restart, "service[siloc-processamento-geracaoxml-job]", :delayed
end
