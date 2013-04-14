#
# Cookbook Name:: os_base
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_package "yum-plugin-fastestmirror" do
  action :install
  options "-y"
end
