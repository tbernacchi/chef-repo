#
# Cookbook:: stl-app-sms-mail
# Recipe:: app-sms-mail
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# install sms-email package
yum_package 'sms-email' do
        allow_downgrade true
        package_name    'sms-email'
        version         '0.0.1-2'
        action          [ :install]
        not_if          "test -f /opt/app/config/config.js"
end

# install nodejs package
yum_package 'nodejs' do
        allow_downgrade true
        package_name    'nodejs'
        version         '6.14.3-1.el7'
        action          [ :install]
        not_if          "test -f /usr/bin/node"
end

execute "chown-svc-notify" do
  command "chown -R svc-notify /opt/app"
  user "svc-notify"
  action :run
  not_if "stat -c %U /opt/app | grep svc-notify"
end

# Entrega do arquivo de rotinas no crond
cookbook_file '/etc/cron.d/rotinas-sms-mail' do
  source 'crond/rotinas-sms-mail'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Entrega do arquivo de monitoria no crond
cookbook_file '/etc/cron.d/monit-sms-mail' do
  source 'crond/monit-sms-mail'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
end

# Entrega do arquivo de systemd
cookbook_file '/etc/systemd/system/sms-mail-dispatcher.service' do
  source 'systemd/sms-mail-dispatcher.service'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :run, 'execute[daemon-reload-restart]', :immediately
end

link '/etc/systemd/system/multi-user.target.wants/sms-mail-dispatcher.service' do
  to '/etc/systemd/system/sms-mail-dispatcher.service'
end

# sudoers
cookbook_file '/etc/sudoers.d/01-sudoers-sms' do
  source 'sudoersd/01-sudoers-sms'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end


# Daemon reload and restart
execute "daemon-reload-restart" do
 user "root"
 command "systemctl daemon-reload; systemctl restart sms-mail-dispatcher.service"
 action :nothing
end

# Cria o diretorio dos scripts que estao no cron
%w{ /usr/local/bin/monits-sms-email /usr/local/bin/rotinas-sms-email  }.each do |dirs|
        directory "#{dirs}" do
                owner "root"
                group "root"
                mode 0755
                action :create
        end
end

# Entrega os files
cookbook_file '/usr/local/bin/rotinas-sms-email/zipa-log.sh' do
  source 'bin/zipa-log.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Entrega os files
cookbook_file '/usr/local/bin/monits-sms-email/check-age-log-sms.sh' do
  source 'bin/check-age-log-sms.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Entrega os files
cookbook_file '/usr/local/bin/monits-sms-email/seek-shell.sh' do
  source 'bin/seek-shell.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Entrega os files
cookbook_file '/usr/local/bin/monits-sms-email/total-msg.sh' do
  source 'bin/total-msg.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
