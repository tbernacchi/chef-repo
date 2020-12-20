template '/etc/yum.repos.d/kubernetes.repo' do
 source 'kubernetes.repo.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end
