default['etcd']['prod']['srv01_host'] = 'zubernetes01'
default['etcd']['prod']['srv02_host'] = 'zubernetes02'
default['etcd']['prod']['srv03_host'] = 'zubernetes03'
default['etcd']['prod']['srv01_ip'] = '10.150.174.177'
default['etcd']['prod']['srv02_ip'] = '10.150.174.178'
default['etcd']['prod']['srv03_ip'] = '10.150.174.179'

# NFS Config
default['etcd']['prod']['nfs_path'] = '/etc/ssl/etcd/ssl/'
default['etcd']['prod']['nfs_mount'] = '/mnt/share'
default['etcd']['prod']['nfs_host'] = 'zubernetes01.tabajara.intranet'
