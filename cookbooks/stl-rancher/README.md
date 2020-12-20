# stl-rancher

TODO: Enter the cookbook description here.

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 10.150.174.177:6443 --token ywv1oi.2kauulmi5n4s6ijr \
    --discovery-token-ca-cert-hash sha256:e7129eb61178450291911cc724c2cca08cab108ae3fd029949305626831afa41

kube_token=$(kubeadm token list | tail -1 | awk '{print $1}')
kube_hash=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')
