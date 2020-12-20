execute "yum-clean-all" do
        command "yum clean all"
        action :run
end

%w{/opt/siloc /opt/siloc/entrada/siloc-entrada-credenciamento-job /opt/siloc/entrada/siloc-entrada-credenciamento-job/config /opt/siloc/entrada/siloc-entrada-credenciamento-job/lib /opt/siloc/entrada/siloc-entrada-credenciamento-job/logs}.each do |dirs|
        directory "#{dirs}" do
                owner "siloc"
                group "siloc"
                mode 0755
                action :create
        end
end
if node.chef_environment == "qa"
  systemd_unit 'siloc-entrada-credenciamento-job.service' do
    content({Unit: {
              Description: 'Siloc-entrada-credenciamento',
              After: 'syslog.target',
            },
            Service: {
              User: 'siloc',
              WorkingDirectory: '/opt/siloc/entrada/siloc-entrada-credenciamento-job/',
              ExecStart: '/usr/bin/java -server -Xms512m -Xmx512m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9020 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/entrada/siloc-entrada-credenciamento-job/lib/siloc-entrada-credenciamento-job.jar --spring.config.name=siloc-entrada-credenciamento-job-config --spring.config.location=file:/opt/siloc/entrada/siloc-entrada-credenciamento-job/config/',
  	          ExecStop: '/bin/kill -s TERM $MAINPID',
              Restart: 'always',
              SuccessExitStatus: '143',
            },
            Install: {
              WantedBy: 'multi-user.target',
            }})
    action [ :create ]
  end
end

if node.chef_environment == "prod"
  systemd_unit 'siloc-entrada-credenciamento-job.service' do
    content({Unit: {
              Description: 'Siloc-entrada-credenciamento',
              After: 'syslog.target',
            },
            Service: {
              User: 'siloc',
              WorkingDirectory: '/opt/siloc/entrada/siloc-entrada-credenciamento-job/',
              ExecStart: '/usr/bin/java -server -Xms1536m -Xmx1536m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9020 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/entrada/siloc-entrada-credenciamento-job/lib/siloc-entrada-credenciamento-job.jar --spring.config.name=siloc-entrada-credenciamento-job-config --spring.config.location=file:/opt/siloc/entrada/siloc-entrada-credenciamento-job/config/',
  	          ExecStop: '/bin/kill -s TERM $MAINPID',
              Restart: 'always',
              SuccessExitStatus: '143',
            },
            Install: {
              WantedBy: 'multi-user.target',
            }})
    action [ :create ]
  end
end

service "siloc-entrada-credenciamento-job" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
end

template "/opt/siloc/entrada/siloc-entrada-credenciamento-job/config/siloc-entrada-credenciamento-job-config.yml" do
        owner "siloc"
        group "siloc"
        mode 0644
        source "opt/siloc/entrada/siloc-entrada-credenciamento-job/config/siloc-entrada-credenciamento-job-config.yml.erb"
        notifies :restart, "service[siloc-entrada-credenciamento-job]", :delayed
end
