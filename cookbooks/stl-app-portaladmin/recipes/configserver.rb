directory "/opt/teste-git/" do
        owner "root"
        group "root"
        mode 0755
        action :create
end

git '/opt/test-git/' do
  repository 'git@git.tabajara.local:sources/channels/portal-admin/configserver.git'
  revision 'master'
  timeout 10
  user 'svc-portaladmin'
  ssh_wrapper "ssh -i /home/svc-portaladmin/.ssh/id_rsa"
  action :sync
end
