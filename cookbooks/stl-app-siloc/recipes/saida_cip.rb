execute "yum-clean-all" do
        command "yum clean all"
        action :run
end

%w{/opt/siloc /opt/siloc/saida/ /opt/siloc/saida/siloc-saida-cip-job /opt/siloc/saida/siloc-saida-cip-job/config /opt/siloc/saida/siloc-saida-cip-job/lib /opt/siloc/saida/siloc-saida-cip-job/logs}.each do |dirs|
        directory "#{dirs}" do
                owner "siloc"
                group "siloc"
                mode 0755
                action :create
        end
end

yum_package 'siloc-saida-cip-job' do
          allow_downgrade true
          package_name    'siloc-saida-cip-job'
          if node.chef_environment == "prod"
           version         node['siloc']['applications'][node.chef_environment]['version']
          end
          action          [ :upgrade]
          notifies :restart, "service[siloc-saida-cip-job]", :delayed

end

systemd_unit 'siloc-saida-cip-job.service' do
  content({Unit: {
            Description: 'Siloc-saida-cip',
            After: 'syslog.target',
          },
          Service: {
            User: 'siloc',
            WorkingDirectory: '/opt/siloc/saida/siloc-saida-cip-job/',
            ExecStart: '/usr/bin/java -server -Xms512m -Xmx512m -XX:+UseParNewGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=25 -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=9023 -Dcom.sun.management.jmxremote.local.only=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -jar /opt/siloc/saida/siloc-saida-cip-job/lib/siloc-saida-cip-job.jar --spring.config.name=siloc-saida-cip-job-config --spring.config.location=file:/opt/siloc/saida/siloc-saida-cip-job/config/',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            Restart: 'always',
            SuccessExitStatus: '143',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [:create]
end

service "siloc-saida-cip-job" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end

template "/opt/siloc/saida/siloc-saida-cip-job/config/siloc-saida-cip-job-config.yml" do
        owner "siloc"
        group "siloc"
        mode 0644
        source "opt/siloc/saida/siloc-saida-cip-job/config/siloc-saida-cip-job-config.yml.erb"
        notifies :restart, "service[siloc-saida-cip-job]", :delayed
end
