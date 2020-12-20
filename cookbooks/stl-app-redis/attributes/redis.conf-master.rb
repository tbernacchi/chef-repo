# Redis
# Master
default['redis']['cluster']['master']['tcp-keepalive'] = '60'
default['redis']['cluster']['master']['requirepass'] = '12pin45pin'

# conf para cluster
default['redis']['cluster']['master']['cluster-enabled'] = 'yes'
