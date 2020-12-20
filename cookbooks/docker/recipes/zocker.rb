#
# Cookbook:: docker
# Recipe:: zocker
#
# Copyright:: 2019, The Authors, All Rights Reserved.
docker_container 'registry' do
 runtime 'docker-runc' 
 repo 'registry'
 tag '2'
 restart_policy 'always'
 port [ '5000:5000' ] 
 action :run    
 restart_policy 'always' 
end

docker_container 'tabajara-spring-cloud-server' do
 runtime 'docker-runc' 
 repo 'registry.tabajara.intranet:5000/v2/tabajara-spring-cloud-server'
 tag 'latest'
 restart_policy 'always'
 port [ '8888:8888' ] 
 action :run    
end

docker_container 'artifactory' do
 runtime 'docker-runc' 
 repo 'mattgruter/artifactory'
 tag 'latest'
 restart_policy 'always'
 env 'RUNTIME_OPTS=-Xms512m -Xmx512m'
 port [ '8080:8080' ] 
 publish_all_ports
 action :run    
end

docker_container 'nexus' do
 runtime 'docker-runc' 
 repo 'sonatype/nexus3'
 tag 'latest'
 restart_policy 'always'
 port [ '8081:8081', '9080:9080', '9081:9081', '9082:9082', '9083:9083' ] 
 action :run    
end

docker_container 'gitlab-runner' do 
 runtime 'docker-runc' 
 repo 'gitlab/gitlab-runner'
 tag 'latest'
 restart_policy 'always'
 volumes [ '/var/run/docker.sock:/var/run/docker.sock', '/srv/gitlab-runner/config:/etc/gitlab-runner' ] 
 action :run
end 

docker_container 'gitlab-runner-2' do 
 runtime 'docker-runc' 
 repo 'gitlab/gitlab-runner'
 tag 'latest'
 restart_policy 'always'
 volumes [ '/var/run/docker.sock:/var/run/docker.sock' ] 
 action :run
end 
