#
# Cookbook Name:: cdh
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cloudera_repo_base = "http://archive.cloudera.com/cdh4"
gpg_key_package = "RPM-GPG-KEY-cloudera"
cdh_package = "cloudera-cdh-4-0.x86_64.rpm"

remote_file "/tmp/#{gpg_key_package}" do
  source "#{cloudera_repo_base}/redhat/6/x86_64/cdh/#{gpg_key_package}"
  action :create_if_missing
end

rpm_package "gpg_key_package" do
  action :install
  options "--import"
  source "/tmp/#{gpg_key_package}"
end

remote_file  "/tmp/#{cdh_package}" do
  source "#{cloudera_repo_base}/one-click-install/redhat/6/x86_64/#{cdh_package}"
  action :create_if_missing
end

rpm_package "cdh_package" do
  action :install
  options "-ivh"
  source "/tmp/#{cdh_package}"
end

yum_package "hadoop-0.20-conf-pseudo" do
  action :install
  options "-y"
end

