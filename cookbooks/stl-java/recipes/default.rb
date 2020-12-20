#
# Cookbook:: stl-java
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package "java-1.8.0-openjdk.x86_64" do
        action :install
        not_if "test -f /usr/bin/java"
end

# Se o jstat nao estiver instalado
# Necessario para o monitoramento de JVM no Zabbix
package "java-1.8.0-openjdk-devel.x86_64" do
        action :install
        not_if "test -d /bin/jstat"
end

# Instalacao do BC para uso do script de monitoramento da JVM com jstat
package "bc.x86_64" do
        action :install
        not_if "test -d /bin/bc"
end
