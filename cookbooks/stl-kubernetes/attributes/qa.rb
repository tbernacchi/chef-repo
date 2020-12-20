default['k8s']['qa']['M01_host'] = 'hzubernetes01'
default['k8s']['qa']['M02_host'] = 'hzubernetes02'
default['k8s']['qa']['M03_host'] = 'hzubernetes03'
default['k8s']['qa']['M01_fqdn'] = 'hzubernetes01.qa.tabajara.intranet'
default['k8s']['qa']['M02_fqdn'] = 'hzubernetes02.qa.tabajara.intranet'
default['k8s']['qa']['M03_fqdn'] = 'hzubernetes03.qa.tabajara.intranet'
default['k8s']['qa']['M01_ip'] = '10.151.57.20'
default['k8s']['qa']['M02_ip'] = '10.151.57.21'
default['k8s']['qa']['M03_ip'] = '10.151.57.22'
default['k8s']['qa']['W01_ip'] = '10.151.57.23'
default['k8s']['qa']['W02_ip'] = '10.151.57.24'
default['k8s']['qa']['W03_ip'] = '10.151.57.25'
default['k8s']['qa']['W04_ip'] = '10.151.57.26'
default['k8s']['qa']['W05_ip'] = '10.151.57.27'

default['k8s']['qa']['vip'] = '10.151.57.30'

# Nfs config
default['k8s']['qa']['nfs_path'] = '/mnt/k8s_install'
default['k8s']['qa']['nfs_mount'] = '/mnt/k8s_nodes'

# NFS do spag em QA
default['k8s']['qa']['spag_path_apps'] = '/opt/spag'

# gluster
default['k8s']['qa']['gfs_path_apps'] = '/volume-k8s-qa-apps/spag'

# proxy tabajara
default['k8s']['qa']['http_proxy'] = 'http://proxy.qa.tabajara.intranet:3130/'
default['k8s']['qa']['no_proxy'] = '.tabajara.local, .tabajara.intranet, 10.0.0.0/8'

# Kube* versions
default['k8s']['kubelet']['version'] = '1.14.0-0'
default['k8s']['kubectl']['version'] = '1.14.0-0'
default['k8s']['kubeadm']['version'] = '1.14.0-0'

# Cluster ClusterConfiguration
default['k8s']['qa']['kubernetesVersion'] = 'v1.14.0'
default['k8s']['qa']['apiVersion'] = 'v1beta1'
default['k8s']['qa']['ClusterName'] = 'tabajara-qa01'
default['k8s']['qa']['endpoints'] = '["https://10.151.57.20:2379", "https://10.151.57.21:2379", "https://10.151.57.22:2379"]'
default['k8s']['qa']['caFile'] = '/etc/ssl/etcd/ssl/ca.pem'
default['k8s']['qa']['certFile'] = '/etc/ssl/etcd/ssl/ca.pem'
default['k8s']['qa']['keyFile'] = '/etc/ssl/etcd/ssl/ca-key.pem'
default['k8s']['qa']['serviceSubnet'] = '10.96.0.0/12'
default['k8s']['qa']['podSubnet'] = '10.100.0.1/24'
default['k8s']['qa']['dnsDomain'] = 'cluster.local'

# Keepalived Config
default['k8s']['qa']['keepalived']['interface'] = 'ens160'
default['k8s']['qa']['keepalived']['virtal_ip'] = '10.151.57.30'
default['k8s']['qa']['keepalived']['master_prio'] = '101'
default['k8s']['qa']['keepalived']['bakup_prio'] = '100'
default['k8s']['qa']['keepalived']['pass'] = '$t&l0'
default['k8s']['qa']['keepalived']['script_path'] = '/etc/keepalived/check_apiserver.sh'
