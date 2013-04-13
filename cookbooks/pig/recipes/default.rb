#
# Cookbook Name:: pig
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

yum_package "pig" do
  action :install
end

file "/home/vagrant/.pigbootup" do
  owner "vagrant"
  group "vagrant"
  mode "644"
  action :create_if_missing
end
