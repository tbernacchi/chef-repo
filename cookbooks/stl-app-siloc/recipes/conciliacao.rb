include_recipe "stl-java"

execute "yum-clean-all" do
        command "yum clean all"
        action :run
end

%w{ /opt/siloc/entrada/siloc-entrada-conciliacao-job/config /opt/siloc/entrada/siloc-entrada-conciliacao-job/lib /opt/siloc/entrada/siloc-entrada-conciliacao-job/logs }.each do |dirs|
  directory "#{dirs}" do
    owner "siloc"
    group "siloc"
    mode 0755
    recursive true
    action :create
  end
end

template "/opt/siloc/entrada/siloc-entrada-conciliacao-job/config/siloc-entrada-conciliacao-job-config.yml" do
        owner "siloc"
        group "siloc"
        mode 0644
        source "opt/siloc/entrada/siloc-entrada-conciliacao-job/config/siloc-entrada-conciliacao-job-config.yml.erb"
        notifies :restart, "service[siloc-entrada-conciliacao-job]", :delayed
end

yum_package 'siloc-entrada-conciliacao-job' do
          allow_downgrade true
          package_name    'siloc-entrada-conciliacao-job'
          if node.chef_environment == "prod"
           version         node['siloc']['applications'][node.chef_environment]['version']
          end
          action          [ :upgrade]
          notifies :restart, "service[siloc-entrada-conciliacao-job]", :delayed
end


if node.chef_environment == "qa"
  systemd_unit 'siloc-entrada-conciliacao-job.service' do
    content({Unit: {
              Description: 'Siloc-entrada-conciliacao',
              After: 'syslog.target',
            },
            Service: {
              User: 'siloc',
              WorkingDirectory: '/opt/siloc/entrada/siloc-entrada-conciliacao-job/',
              ExecStart: '/usr/bin/java -server -Xms512m -Xmx512m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9020 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/entrada/siloc-entrada-conciliacao-job/lib/siloc-entrada-conciliacao-job.jar --spring.config.name=siloc-entrada-conciliacao-job-config --spring.config.location=file:/opt/siloc/entrada/siloc-entrada-conciliacao-job/config/',
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
  systemd_unit 'siloc-entrada-conciliacao-job.service' do
    content({Unit: {
              Description: 'Siloc-entrada-conciliacao',
              After: 'syslog.target',
            },
            Service: {
              User: 'siloc',
              WorkingDirectory: '/opt/siloc/entrada/siloc-entrada-conciliacao-job/',
              ExecStart: '/usr/bin/java -server -Xms1536m -Xmx1536m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9029 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/entrada/siloc-entrada-conciliacao-job/lib/siloc-entrada-conciliacao-job.jar --spring.config.name=siloc-entrada-conciliacao-job-config --spring.config.location=file:/opt/siloc/entrada/siloc-entrada-conciliacao-job/config/',
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

service "siloc-entrada-conciliacao-job" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [ :enable, :start ]
end
