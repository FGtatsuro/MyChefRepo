#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

java_home = '/usr/java/jdk1.6.0_43'

template '/home/vagrant/.bashrc' do
  source 'bashrc.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '644'
end

template '/root/.bashrc' do
  source 'bashrc.erb'
  owner 'root'
  group 'root'
  mode '644'
end

execute 'wget_jdk' do
  command 'wget --no-check-certificate --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com" http://download.oracle.com/otn-pub/java/jdk/6u43-b01/jdk-6u43-linux-x64-rpm.bin -O /tmp/jdk-6u43-linux-x64-rpm.bin'
  user 'root'
  not_if {File.exists?('/tmp/jdk-6u43-linux-x64-rpm.bin')}
end

file 'chmod_jdk' do
  path '/tmp/jdk-6u43-linux-x64-rpm.bin'
  owner 'root'
  group 'root'
  mode '755'
  action :touch
  only_if {File.exists?('/tmp/jdk-6u43-linux-x64-rpm.bin')}
end

execute 'install_jdk' do
  command '/tmp/jdk-6u43-linux-x64-rpm.bin'
  user 'root'
  not_if {File.exists?('/usr/java/default/bin/java')}
end
