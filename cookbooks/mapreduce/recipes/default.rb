#
# Cookbook Name:: mapreduce
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service "hadoop-0.20-mapreduce-jobtracker" do
  action :start
  notifies :start, "service[hadoop-0.20-mapreduce-tasktracker]", :immediately
end

service "hadoop-0.20-mapreduce-tasktracker" do
  action :nothing
end
