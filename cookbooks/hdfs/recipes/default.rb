#
# Cookbook Name:: hdfs
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

hadoop_metadata_dir = "/var/lib/hadoop-hdfs/cache/hdfs/dfs/name"
hadoopfs_cmd = "hadoop fs"
hdfs_system_cache = "/var/lib/hadoop-hdfs/cache"
sampleuser_home = "/user/sampleuser"
sampleuser_name = "sampleuser"

execute "namenode_format" do
  command "hdfs namenode -format"
  user "hdfs"
  group "hdfs"
  not_if {File.exists?("#{hadoop_metadata_dir}")}
end

service "hadoop-hdfs-namenode" do
  action :start
  notifies :start, "service[hadoop-hdfs-datanode]", :immediately
end

service "hadoop-hdfs-datanode" do
  action :nothing
  notifies :run, "execute[create_cache]", :immediately
end

execute "create_cache" do
  command "#{hadoopfs_cmd} -mkdir -p #{hdfs_system_cache}"
  user "hdfs"
  group "hdfs"
  notifies :run, "execute[chmod_cache]", :immediately
end

execute "chmod_cache" do
  command "#{hadoopfs_cmd} -chmod -R 1777 #{hdfs_system_cache}"
  user "hdfs"
  group "hdfs"
end

user "#{sampleuser_name}" do
  action :create
  notifies :run, "execute[create_sampleuser_home]", :immediately
end

execute "create_sampleuser_home" do
  command "#{hadoopfs_cmd} -mkdir -p #{sampleuser_home}"
  user "hdfs"
  group "hdfs"
  notifies :run, "execute[chown_sampleuser_home]", :immediately
end

execute "chown_sampleuser_home" do
  command "#{hadoopfs_cmd} -chown #{sampleuser_name} #{sampleuser_home}"
  user "hdfs"
  group "hdfs"
end
