#
# Cookbook:: stl-ntp
# Recipe:: horario-verao
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# yum clean all
execute "yum-clean-all" do
       command "yum clean all"
       action :run
end

# De acordo com o decreto http://pcdsh01.on.br/DecHV9772EXTRA.pdf_20190426.pdf
# o horario de verao foi removido o calendario oficial e para tanto precisamos
# remover a agenda que deveria ocorrer na 0h dia 03 de Novembro de 2019 conforme
# abaixo: 
# /usr/share/zoneinfo/America/Sao_Paulo  Sun Feb 17 02:00:00 2019 UTC = Sat Feb 16 23:00:00 2019 -03 isdst=0 gmtoff=-10800
# /usr/share/zoneinfo/America/Sao_Paulo  Sun Nov  3 02:59:59 2019 UTC = Sat Nov  2 23:59:59 2019 -03 isdst=0 gmtoff=-10800
# /usr/share/zoneinfo/America/Sao_Paulo  Sun Nov  3 03:00:00 2019 UTC = Sun Nov  3 01:00:00 2019 -02 isdst=1 gmtoff=-7200

# pkgs
# install tzdata (S0) e tzdata-java (JAVA)
yum_package 'tzdata' do
  allow_downgrade true
  package_name    'tzdata'
#  version         '2019b-1.el7'
  action          [ :upgrade]
end

yum_package 'tzdata-java' do
  allow_downgrade true
  package_name    'tzdata-java'
#  version         '2019b-1.el7'
  action          [ :upgrade]
end
