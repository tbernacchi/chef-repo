# net
default["infra"]["cluster-net"]["pod_network_cidr"] = "10.101.0.1/24"
default["infra"]["cluster-net"]["service_cidr"] = "10.97.0.0/24"
default["infra"]["cluster-net"]["apiserver_advertise_address"] = "10.150.164.23"

 # Kube* versions
default["infra"]["kubelet"]["version"] = "1.14.0-0"
default["infra"]["kubectl"]["version"] = "1.14.0-0"
default["infra"]["kubeadm"]["version"] = "1.14.0-0"

# proxy
# proxy tabajara
default["infra"]["prod"]["http_proxy"] = "http://proxy.tabajara.intranet:3130/"
default["infra"]["prod"]["https_proxy"] = "http://proxy.tabajara.intranet:3130/"
default["infra"]["prod"]["no_proxy"] = ".tabajara.local, .tabajara.intranet, 10.0.0.0/8"

# para nfs
default["infra"]["cluster-master"] = "zica01.tabajara.intranet"
default["infra"]["prod"]["nfs_path"] = "/share-k8s"
default["infra"]["prod"]["nfs_mount"] = "/mnt/k8s_nodes"
default['infra']['prod']['W01_host'] = 'zicado01.tabajara.intranet'
default['infra']['prod']['W02_host'] = 'zicado02.tabajara.intranet'

