name 'stl-ldap'
maintainer 'Infra team'
maintainer_email 'gr_infra@tabajara.com.br'
license 'All Rights Reserved'
description 'Installs/Configures stl-ldap'
long_description 'Installs/Configures stl-ldap'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

# Esse Cookbook serve para adicionar os atributos de LDAP do tabajara.corp em seu SEU_PROJETO
# nao esquecer de alterar o valor da chave "groupsearchbase" para a OU do SEU_PROJETO
