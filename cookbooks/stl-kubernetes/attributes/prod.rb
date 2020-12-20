default['k8s']['prod']['M01_host'] = 'zubernetes01'
default['k8s']['prod']['M02_host'] = 'zubernetes02'
default['k8s']['prod']['M03_host'] = 'zubernetes03'
default['k8s']['prod']['M01_fqdn'] = 'zubernetes01.tabajara.intranet'
default['k8s']['prod']['M02_fqdn'] = 'zubernetes02.tabajara.intranet'
default['k8s']['prod']['M03_fqdn'] = 'zubernetes03.tabajara.intranet'
default['k8s']['prod']['M01_ip'] = '10.150.174.177'
default['k8s']['prod']['M02_ip'] = '10.150.174.178'
default['k8s']['prod']['M03_ip'] = '10.150.174.179'
default['k8s']['prod']['W01_ip'] = '10.150.174.159'
default['k8s']['prod']['W02_ip'] = '10.150.174.160'
default['k8s']['prod']['W03_ip'] = '10.150.174.161'
default['k8s']['prod']['W04_ip'] = '10.150.174.187'
default['k8s']['prod']['W05_ip'] = '10.150.174.188'
default['k8s']['prod']['W06_ip'] = '10.150.174.132'
default['k8s']['prod']['W07_ip'] = '10.150.174.133'
default['k8s']['prod']['W08_ip'] = '10.150.174.176'

default['k8s']['prod']['vip'] = '10.150.174.186'

# Nfs config
default['k8s']['prod']['nfs_path'] = '/mnt/k8s_install'
default['k8s']['prod']['nfs_mount'] = '/mnt/k8s_nodes'

# gluster
default['k8s']['prod']['gfs_path_apps'] = '/volume-k8s-prod-apps/spag'
default['k8s']['prod']['dfin_vol'] = '/volume-dfin'


# proxy tabajara
default['k8s']['prod']['http_proxy'] = 'http://proxy.tabajara.intranet:3130/'
default['k8s']['prod']['no_proxy'] = '.tabajara.local, .tabajara.intranet, 10.0.0.0/8'

# Kube* versions
default['k8s']['kubelet']['version'] = '1.14.0-0'
default['k8s']['kubectl']['version'] = '1.14.0-0'
default['k8s']['kubeadm']['version'] = '1.14.0-0'

# Cluster ClusterConfiguration
default['k8s']['prod']['kubernetesVersion'] = 'v1.14.0'
default['k8s']['prod']['apiVersion'] = 'v1beta1'
default['k8s']['prod']['ClusterName'] = 'tabajara-prod01'
default['k8s']['prod']['endpoints'] = '["https://10.150.174.177:2379", "https://10.150.174.178:2379", "https://10.150.174.179:2379"]'
default['k8s']['prod']['caFile'] = '/etc/ssl/etcd/ssl/ca.pem'
default['k8s']['prod']['certFile'] = '/etc/ssl/etcd/ssl/ca.pem'
default['k8s']['prod']['keyFile'] = '/etc/ssl/etcd/ssl/ca-key.pem'
default['k8s']['prod']['serviceSubnet'] = '10.96.0.0/12'
default['k8s']['prod']['podSubnet'] = '10.100.0.1/24'
default['k8s']['prod']['dnsDomain'] = 'cluster.local'

# Keepalived Config
default['k8s']['prod']['keepalived']['interface'] = 'ens160'
default['k8s']['prod']['keepalived']['virtal_ip'] = '10.150.174.186'
default['k8s']['prod']['keepalived']['master_prio'] = '101'
default['k8s']['prod']['keepalived']['bakup_prio'] = '100'
default['k8s']['prod']['keepalived']['pass'] = '$t&l0'
default['k8s']['prod']['keepalived']['script_path'] = '/etc/keepalived/check_apiserver.sh'
