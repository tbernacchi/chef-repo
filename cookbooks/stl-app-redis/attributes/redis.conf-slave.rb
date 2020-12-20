# Slave

default['redis']['cluster']['slave']['slaveof_host_port'] = '6379'

# conf para cluster
default['redis']['cluster']['master']['cluster-enabled'] = 'yes'

# Producao
# Test fqdn for slave
# Rule 2 > 1
if node['fqdn'] == 'quintal02.tabajara.intranet'
        default['redis']['cluster']['slave']['slaveof_host'] = 'quintal01.tabajara.intranet'
        default['redis']['cluster']['slave']['masterauth'] = '12pin45pin'
end

# Rule 4 > 3
if node['fqdn'] == 'quintal04.tabajara.intranet'
        default['redis']['cluster']['slave']['slaveof_host'] = 'quintal03.tabajara.intranet'
        default['redis']['cluster']['slave']['masterauth'] = '12pin45pin'
end

# Rule 6 > 5
if node['fqdn'] == 'quintal06.tabajara.intranet'
        default['redis']['cluster']['slave']['slaveof_host'] = 'quintal05.tabajara.intranet'
        default['redis']['cluster']['slave']['masterauth'] = '12pin45pin'
end

# --------

# QA
if node['fqdn'] == 'hquintal02.qa.tabajara.intranet'
        default['redis']['cluster']['slave']['slaveof_host'] = 'hquintal01.qa.tabajara.intranet'
        default['redis']['cluster']['slave']['masterauth'] = '12pin45pin'
end

if node['fqdn'] == 'hquintal04.qa.tabajara.intranet'
        default['redis']['cluster']['slave']['slaveof_host'] = 'hquintal03.qa.tabajara.intranet'
        default['redis']['cluster']['slave']['masterauth'] = '12pin45pin'
end
