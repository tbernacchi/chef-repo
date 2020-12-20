cookbook_file '/tmp/libnet-1.1.6-7.el7.x86_64.rpm' do
 source 'libnet-1.1.6-7.el7.x86_64.rpm'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

cookbook_file '/tmp/ngrep-1.47-1.1.el7.x86_64.rpm' do
 source 'ngrep-1.47-1.1.el7.x86_64.rpm'
 owner 'root'
 group 'root'
 mode '0644'
 action :create
end

yum_package 'tcpdump' do
 action :install
 not_if { File.exist? ("/usr/sbin/tcpdump") } 
end

execute 'Installing libnet-1.1.6-7 library' do
 command 'rpm -i /tmp/libnet-1.1.6-7.el7.x86_64.rpm'
 not_if { File.exist? ( "/usr/lib64/libnet.so.1") }
end

execute 'Installing ngrep package' do
 command 'rpm -i /tmp/ngrep-1.47-1.1.el7.x86_64.rpm'
 not_if { File.exist? ( "/usr/sbin/ngrep") }
end
