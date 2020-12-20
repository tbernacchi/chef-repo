# stl-etcd

# Ambiente de QA

## FLUSH
```console
ETCDCTL_API=3 etcdctl  --endpoints=https://10.151.57.20:2379,https://10.151.57.21:2379,https://10.151.57.22:2379  --ca-file=/etc/ssl/etcd/ssl/ca.pem --cert-file=/etc/ssl/etcd/ssl/member-hzubernetes01.pem --key-file=/etc/ssl/etcd/ssl/member-hzubernetes01-key.pem del "" --from-key=true
```

## Check Health
```console
etcdctl --ca-file=/etc/ssl/etcd/ssl/ca.pem --cert-file=/etc/ssl/etcd/ssl/member-hzubernetes01.pem --key-file=/etc/ssl/etcd/ssl/member-hzubernetes01-key.pem --endpoints=https://10.151.57.20:2379,https://10.151.57.21:2379,https://10.151.57.22:2379 cluster-health
```

## Member List
```console
etcdctl --ca-file=/etc/ssl/etcd/ssl/ca.pem --cert-file=/etc/ssl/etcd/ssl/member-hzubernetes01.pem --key-file=/etc/ssl/etcd/ssl/member-hzubernetes01-key.pem --endpoints=https://10.151.57.20:2379,https://10.151.57.21:2379,https://10.151.57.22:2379 member list
```

# Ambiente de LAB

## FLUSH
```console
ETCDCTL_API=3 etcdctl  --endpoints=https://10.150.122.9:2379,https://10.150.122.10:2379,https://10.150.122.11:2379:2379  --ca-file=/etc/ssl/etcd/ssl/ca.pem --cert-file=/etc/ssl/etcd/ssl/member-zaster01.pem --key-file=/etc/ssl/etcd/ssl/member-zaster01-key.pem del "" --from-key=true
```

## Check Health
```console
etcdctl --ca-file=/etc/ssl/etcd/ssl/ca.pem --cert-file=/etc/ssl/etcd/ssl/member-zaster01.pem --key-file=/etc/ssl/etcd/ssl/member-zaster01-key.pem --endpoints=https://10.150.122.9:2379,https://10.150.122.10:2379,https://10.150.122.11:2379 cluster-health
```

## Member List
```console
etcdctl --ca-file=/etc/ssl/etcd/ssl/ca.pem --cert-file=/etc/ssl/etcd/ssl/member-zaster01.pem --key-file=/etc/ssl/etcd/ssl/member-zaster01-key.pem --endpoints=https://10.150.122.9:2379,https://10.150.122.10:2379,https://10.150.122.11:2379 member list
```
