name 'stl-kubernetes'
maintainer 'The Authors'
maintainer_email 'you@example.com'
license 'All Rights Reserved'
description 'Installs/Configures stl-kubernetes'
long_description 'Installs/Configures stl-kubernetes'
version '0.2.4'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends "stl-repo"
depends "stl-docker"
depends "stl-keepalived"

# 0.1.1 ambiente de QA feito
# 0.2.1 primeira versao em ambiente de Prod
# 0.2.2 add /opt/dfinarquivos para o serviço do ECF
# 0.2.3 Add new_worker_nodes in production
# 0.2.4 Add spag nfs in /opt/spag
