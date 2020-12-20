name 'stl-app-siloc'
maintainer 'Infra Team'
maintainer_email 'gr_infra@tabajara.com.br'
license 'All Rights Reserved'
description 'Installs/Configures stl-siloc'
long_description 'Installs/Configures stl-siloc'
version '1.0.19'
chef_version '>= 12.14' if respond_to?(:chef_version)

depends "stl-java"
depends "stl-ldap"
depends "stl-nginx"
