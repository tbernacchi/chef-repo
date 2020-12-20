default['k8s']['lab']['M01_host'] = 'zaster01'
default['k8s']['lab']['M02_host'] = 'zaster02'
default['k8s']['lab']['M03_host'] = 'zaster03'
default['k8s']['lab']['M01_fqdn'] = 'zaster01.tabajara.intranet'
default['k8s']['lab']['M02_fqdn'] = 'zaster02.tabajara.intranet'
default['k8s']['lab']['M03_fqdn'] = 'zaster03.tabajara.intranet'
default['k8s']['lab']['M01_ip'] = '10.150.122.9'
default['k8s']['lab']['M02_ip'] = '10.150.122.10'
default['k8s']['lab']['M03_ip'] = '10.150.122.11'
default['k8s']['lab']['W01_ip'] = '10.150.122.12'
default['k8s']['lab']['W02_ip'] = '10.150.122.13'

default['k8s']['lab']['vip'] = '10.150.174.186'

# Nfs config
default['k8s']['lab']['nfs_path'] = '/mnt/k8s_install'
default['k8s']['lab']['nfs_mount'] = '/mnt/k8s_nodes'

# gluster
default['k8s']['lab']['gfs_path_apps'] = '/volume-k8s-prod-apps/spag'


# proxy tabajara
default['k8s']['lab']['http_proxy'] = 'http://proxy.tabajara.intranet:3130/'
default['k8s']['lab']['no_proxy'] = '.tabajara.local, .tabajara.intranet, 10.0.0.0/8'

# Kube* versions
default['k8s']['kubelet']['version'] = '1.14.0-0'
default['k8s']['kubectl']['version'] = '1.14.0-0'
default['k8s']['kubeadm']['version'] = '1.14.0-0'

# Cluster ClusterConfiguration
default['k8s']['lab']['kubernetesVersion'] = 'v1.14.0'
default['k8s']['lab']['apiVersion'] = 'v1beta1'
default['k8s']['lab']['ClusterName'] = 'tabajara-prod01'
default['k8s']['lab']['endpoints'] = '["https://10.150.122.9:2379", "https://10.150.122.10:2379", "https://10.150.122.11:2379"]'
default['k8s']['lab']['caFile'] = '/etc/ssl/etcd/ssl/ca.pem'
default['k8s']['lab']['certFile'] = '/etc/ssl/etcd/ssl/ca.pem'
default['k8s']['lab']['keyFile'] = '/etc/ssl/etcd/ssl/ca-key.pem'
default['k8s']['lab']['serviceSubnet'] = '10.96.0.0/12'
default['k8s']['lab']['podSubnet'] = '10.100.0.1/24'
default['k8s']['lab']['dnsDomain'] = 'cluster.local'

# Keepalived Config
default['k8s']['lab']['keepalived']['interface'] = 'ens160'
default['k8s']['lab']['keepalived']['virtal_ip'] = '10.150.174.186'
default['k8s']['lab']['keepalived']['master_prio'] = '101'
default['k8s']['lab']['keepalived']['bakup_prio'] = '100'
default['k8s']['lab']['keepalived']['pass'] = '$t&l0'
default['k8s']['lab']['keepalived']['script_path'] = '/etc/keepalived/check_apiserver.sh'
