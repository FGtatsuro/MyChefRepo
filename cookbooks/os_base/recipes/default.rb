#
# Cookbook Name:: os_base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

hostname = node[:os_base][:hostname]

execute "hostname" do
  command "hostname #{hostname}"
  user "root"
end

template "/etc/hosts" do
  source "etc/hosts.erb"
  owner "root"
  group "root"
  mode "644"
  variables(
    :hostname => "#{hostname}"
  )
end

yum_package "yum-plugin-fastestmirror" do
  action :install
  options "-y"
end
