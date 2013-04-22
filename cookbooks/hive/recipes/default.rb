#
# Cookbook Name:: hive
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

hive_home = "/var/lib/hive"

yum_package "hive" do
  action :install
  options "-y"
end

execute "chmod_hive_home" do
  command "chown -R hive:hive #{hive_home}"
  user "root"
  group "root"
  only_if {File.exists?("#{hive_home}")}
end
