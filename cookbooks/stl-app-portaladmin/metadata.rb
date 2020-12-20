name 'stl-app-portaladmin'
maintainer 'Infra Team'
maintainer_email 'gr_infra@tabajara.com.br'
license 'All Rights Reserved'
description 'Installs/Configures stl-app-portaladmin'
long_description 'Installs/Configures stl-app-portaladmin'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends "stl-java"
depends "stl-nginx"
