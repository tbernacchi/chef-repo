execute "yum-clean-all" do
    command "yum clean all"
    action :run
end

yum_package 'etcd' do
  version '3.3.11-2.el7.centos'
  allow_downgrade true
  not_if { File.exist? ("/bin/etcd") }
  action [:install]
end

%w{ /etc/etcd /etc/ssl/ /etc/ssl/etcd/ /etc/ssl/etcd/ssl }.each do |dirs|
  directory "#{dirs}" do
    owner "root"
    group "root"
    mode 0755
    action :create
  end
end

systemd_unit 'etcd.service' do
  content({Unit: {
            Description: 'etcd',
            After: 'network.target',
          },
          Service: {
            Type: 'notify',
            User: 'etcd',
            EnvironmentFile: '/etc/etcd.env',
            ExecStart: '/usr/bin/etcd',
	          ExecStop: '/bin/kill -s TERM $MAINPID',
            NotifyAccess: 'all',
            Restart: 'always',
            RestartSec: '10s',
            SuccessExitStatus: '143',
            LimitNOFILE: '40000',
          },
          Install: {
            WantedBy: 'multi-user.target',
          }})
  action [ :create ]
end

if node['fqdn'] == 'hzubernetes01.qa.tabajara.intranet'
  yum_package 'nfs-utils' do
    allow_downgrade true
    not_if { File.exist? ("/usr/lib/systemd/system/nfs.service") }
    action [:install]
  end

  service "rpcbind" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-server" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-lock" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-idmap" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  template "/etc/exports.d/etcd.exports" do
    owner "root"
    group "root"
    mode 0644
    source "etc/exports.d/etcd.exports.erb"
    notifies :restart, "service[nfs-server]", :immediately
  end

  execute "applying exportfs" do
    command 'exportfs -a'
    action :run
  end

  template "/etc/etcd/openssl01.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl01.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/openssl02.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl02.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/openssl03.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl03.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves01.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves01.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves02.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves02.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves03.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves03.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to hzubernetes01" do
    command 'openssl genrsa -out /etc/etcd/ca-key.pem 2048'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to hzubernetes01" do
    command 'openssl req -x509 -new -nodes -key /etc/etcd/ca-key.pem -days 10000 -out /etc/etcd/ca.pem -subj "/CN=etcd-ca"'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to hzubernetes01" do
    command '/bin/bash /etc/etcd/gen_chaves01.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to hzubernetes02" do
    command '/bin/bash /etc/etcd/gen_chaves02.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to hzubernetes03" do
    command '/bin/bash /etc/etcd/gen_chaves03.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "copiando os certificados para /etc/ssl/etcd/ssl" do
    command 'cp -rfa /etc/etcd/{ca-key.pem,ca.pem,member-hzubernetes01-key.pem,member-hzubernetes01.pem,member-hzubernetes02-key.pem,member-hzubernetes02.pem,member-hzubernetes03-key.pem,member-hzubernetes03.pem} /etc/ssl/etcd/ssl'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "Creating lock file in order to prevent generate news certificates" do
    command 'touch /etc/etcd/certs.lock'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "Creating lock file in order to prevent generate news certificates" do
    command 'chmod -Rv 550 /etc/ssl/etcd/ && chmod 440 /etc/ssl/etcd/ssl/*.pem && chown -Rv etcd:etcd /etc/ssl/etcd/ && chown -Rv etcd:etcd /etc/ssl/etcd/* && chown etcd:etcd /var/lib/etcd/'
    action :run
  end

  execute "Removing all bash files from directory" do
    command 'rm -rf /etc/etcd/*sh && rm -rf /etc/etcd/openssl0*'
    action :run
  end
end

if node['fqdn'] == 'zubernetes01.tabajara.intranet'
  yum_package 'nfs-utils' do
    allow_downgrade true
    not_if { File.exist? ("/usr/lib/systemd/system/nfs.service") }
    action [:install]
  end

  service "rpcbind" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-server" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-lock" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-idmap" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  template "/etc/exports.d/etcd.exports" do
    owner "root"
    group "root"
    mode 0644
    source "etc/exports.d/etcd.exports.erb"
    notifies :restart, "service[nfs-server]", :immediately
  end

  execute "applying exportfs" do
    command 'exportfs -a'
    action :run
  end

  template "/etc/etcd/openssl01.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl01.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/openssl02.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl02.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/openssl03.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl03.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves01.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves01.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves02.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves02.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves03.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves03.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zubernetes01" do
    command 'openssl genrsa -out /etc/etcd/ca-key.pem 2048'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zubernetes01" do
    command 'openssl req -x509 -new -nodes -key /etc/etcd/ca-key.pem -days 10000 -out /etc/etcd/ca.pem -subj "/CN=etcd-ca"'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zubernetes01" do
    command '/bin/bash /etc/etcd/gen_chaves01.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zubernetes02" do
    command '/bin/bash /etc/etcd/gen_chaves02.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zubernetes03" do
    command '/bin/bash /etc/etcd/gen_chaves03.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "copiando os certificados para /etc/ssl/etcd/ssl" do
    command 'cp -rfa /etc/etcd/{ca-key.pem,ca.pem,member-zubernetes01-key.pem,member-zubernetes01.pem,member-zubernetes02-key.pem,member-zubernetes02.pem,member-zubernetes03-key.pem,member-zubernetes03.pem} /etc/ssl/etcd/ssl'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "Creating lock file in order to prevent generate news certificates" do
    command 'touch /etc/etcd/certs.lock'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "Creating lock file in order to prevent generate news certificates" do
    command 'chmod -Rv 550 /etc/ssl/etcd/ && chmod 440 /etc/ssl/etcd/ssl/*.pem && chown -Rv etcd:etcd /etc/ssl/etcd/ && chown -Rv etcd:etcd /etc/ssl/etcd/* && chown etcd:etcd /var/lib/etcd/'
    action :run
  end

  execute "Removing all bash files from directory" do
    command 'rm -rf /etc/etcd/*sh && rm -rf /etc/etcd/openssl0*'
    action :run
  end
end

if node['fqdn'] == 'zaster01.tabajara.intranet'
  yum_package 'nfs-utils' do
    allow_downgrade true
    not_if { File.exist? ("/usr/lib/systemd/system/nfs.service") }
    action [:install]
  end

  service "rpcbind" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-server" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-lock" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  service "nfs-idmap" do
   supports :start => true, :stop => true, :restart => true, :status => true
   action [:enable, :start]
  end

  template "/etc/exports.d/etcd.exports" do
    owner "root"
    group "root"
    mode 0644
    source "etc/exports.d/etcd.exports.erb"
    notifies :restart, "service[nfs-server]", :immediately
  end

  execute "applying exportfs" do
    command 'exportfs -a'
    action :run
  end

  template "/etc/etcd/openssl01.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl01.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/openssl02.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl02.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/openssl03.conf" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/openssl03.conf.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves01.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves01.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves02.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves02.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  template "/etc/etcd/gen_chaves03.sh" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd/gen_chaves03.sh.erb"
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zaster01" do
    command 'openssl genrsa -out /etc/etcd/ca-key.pem 2048'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zaster01" do
    command 'openssl req -x509 -new -nodes -key /etc/etcd/ca-key.pem -days 10000 -out /etc/etcd/ca.pem -subj "/CN=etcd-ca"'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zaster01" do
    command '/bin/bash /etc/etcd/gen_chaves01.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zaster02" do
    command '/bin/bash /etc/etcd/gen_chaves02.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "creating keys and certificates to zaster03" do
    command '/bin/bash /etc/etcd/gen_chaves03.sh'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "copiando os certificados para /etc/ssl/etcd/ssl" do
    command 'cp -rfa /etc/etcd/{ca-key.pem,ca.pem,member-zaster01-key.pem,member-zaster01.pem,member-zaster02-key.pem,member-zaster02.pem,member-zaster03-key.pem,member-zaster03.pem} /etc/ssl/etcd/ssl'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "Creating lock file in order to prevent generate news certificates" do
    command 'touch /etc/etcd/certs.lock'
    action :run
    not_if { File.exist? ("/etc/etcd/certs.lock") }
  end

  execute "Creating lock file in order to prevent generate news certificates" do
    command 'chmod -Rv 550 /etc/ssl/etcd/ && chmod 440 /etc/ssl/etcd/ssl/*.pem && chown -Rv etcd:etcd /etc/ssl/etcd/ && chown -Rv etcd:etcd /etc/ssl/etcd/* && chown etcd:etcd /var/lib/etcd/'
    action :run
  end

  execute "Removing all bash files from directory" do
    command 'rm -rf /etc/etcd/*sh && rm -rf /etc/etcd/openssl0*'
    action :run
  end
end

if node.chef_environment == "qa"
  template "/etc/etcd.env" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd2.env.erb"
  end
end

if node.chef_environment == "prod"
  template "/etc/etcd.env" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd2.env-prod.erb"
  end
end

if node.chef_environment == "lab"
  template "/etc/etcd.env" do
    owner "root"
    group "root"
    mode 0644
    source "etc/etcd.env-lab.erb"
  end
end

service "etcd.service" do
    supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
    ignore_failure true
    action [:enable, :start]
end
