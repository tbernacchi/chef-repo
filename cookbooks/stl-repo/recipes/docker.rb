template '/etc/yum.repos.d/docker-ce.repo' do
 source 'docker-ce.repo.erb'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end
