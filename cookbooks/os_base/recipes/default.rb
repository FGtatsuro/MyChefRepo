#
# Cookbook Name:: os_base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "hostname" do
  command "hostname hadoopenv"
  user "root"
end

yum_package "yum-plugin-fastestmirror" do
  action :install
  options "-y"
end
