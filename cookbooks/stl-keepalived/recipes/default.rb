execute "yum-clean-all" do
    command "yum clean all"
    action :run
end

yum_package 'keepalived' do
  version '1.3.5-8.el7_6'
  allow_downgrade true
  not_if { File.exist? ("/sbin/keepalived") }
  action [:install]
end
