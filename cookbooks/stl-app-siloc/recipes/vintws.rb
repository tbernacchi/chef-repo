cookbook_file '/etc/cron.d/rotinas-cip' do
 source 'etc/cron.d/rotinas-cip'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

yum_package 'glusterfs-client' do
 action :install
 not_if { File.exist? ("/usr/lib64/glusterfs/3.12.2/xlator/protocol/client.so") }
end

mount "/opt/silocarquivos" do
 device "glusterfs.tabajara.intranet:/volume-cip"
 fstype "glusterfs"
 options "defaults,_netdev"
 action [:mount, :enable]
end

mount '/opt/silocarquivos/' do
  device 'zuido01.tabajara.intranet:/volume_nfs/cip'
  fstype 'nfs'
  options 'rw'
  action [:umount, :disable]
 end

 %w{/opt/silocarquivos/scripts/lists /opt/silocarquivos/scripts/monitor }.each do |dirs|
   directory "#{dirs}" do
     owner "nfsnobody"
     group "nfsnobody"
     mode 0755
     action :create
   end
 end

cookbook_file '/opt/silocarquivos/scripts/connect-mon_log_file.sh' do
 source 'opt/silocarquivos/scripts/connect-mon_log_file.sh'
 owner 'root'
 group 'root'
 mode '0755'
 action :create
 notifies :restart, "service[connect_check_new_files]", :delayed
end

cookbook_file '/opt/silocarquivos/scripts/difftime.py' do
 source 'opt/silocarquivos/scripts/difftime.py'
 owner 'nfsnobody'
 group 'nfsnobody'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_job_cip_to_siloc.sh' do
 source 'opt/silocarquivos/scripts/prd_job_cip_to_siloc.sh'
 owner 'nfsnobody'
 group 'nfsnobody'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_job_cnab_cip_to_hp.sh' do
 source 'opt/silocarquivos/scripts/prd_job_cnab_cip_to_hp.sh'
 owner 'svc_cip_ft'
 group 'svc_cip_ft'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_job_move_cnab.sh' do
 source 'opt/silocarquivos/scripts/prd_job_move_cnab.sh'
 owner 'svc_cip_ft'
 group 'svc_cip_ft'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_job_siloc_to_cip.sh' do
 source 'opt/silocarquivos/scripts/prd_job_siloc_to_cip.sh'
 owner 'svc_cip_ft'
 group 'svc_cip_ft'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_mon_cnab.sh' do
 source 'opt/silocarquivos/scripts/prd_mon_cnab.sh'
 owner 'nfsnobody'
 group 'nfsnobody'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_mon_retfile.sh' do
 source 'opt/silocarquivos/scripts/prd_mon_retfile.sh'
 owner 'svc_cip_ft'
 group 'svc_cip_ft'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_mon_siloc_entrada.sh' do
 source 'opt/silocarquivos/scripts/prd_mon_siloc_entrada.sh'
 owner 'nfsnobody'
 group 'nfsnobody'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_mon_siloc_to_cd.sh' do
 source 'opt/silocarquivos/scripts/prd_mon_siloc_to_cd.sh'
 owner 'nfsnobody'
 group 'nfsnobody'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_mon_transfer_cip_to_siloc.sh' do
 source 'opt/silocarquivos/scripts/prd_mon_transfer_cip_to_siloc.sh'
 owner 'nfsnobody'
 group 'nfsnobody'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_mon_conciliacao_retorno.sh' do
 source 'opt/silocarquivos/scripts/prd_mon_conciliacao_retorno.sh'
 owner 'nfsnobody'
 group 'nfsnobody'
 mode '0755'
 action :create
end

cookbook_file '/opt/silocarquivos/scripts/prd_job_conciliacao_retorno.sh' do
 source 'opt/silocarquivos/scripts/prd_job_conciliacao_retorno.sh'
 owner 'nfsnobody'
 group 'nfsnobody'
 mode '0755'
 action :create
end

systemd_unit 'connect_check_new_files.service' do
  content({Unit: {
            Description: 'Connect Check New log files',
            After: 'syslog.target',
          },
          Service: {
            User: 'root',
            WorkingDirectory: '/opt/silocarquivos/scripts/',
            ExecStart: '/opt/silocarquivos/scripts/connect-mon_log_file.sh',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            Restart: 'always',
            SuccessExitStatus: '143',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [ :create ]
end

service "connect_check_new_files" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    action [:enable, :start]
end
