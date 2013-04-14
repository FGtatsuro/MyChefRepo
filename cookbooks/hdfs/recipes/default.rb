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
mapred_system_cache = "/var/lib/hadoop-hdfs/cache/mapred"
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
  command <<-EOH
    #{hadoopfs_cmd} -mkdir -p #{mapred_system_cache}/mapred/staging
    #{hadoopfs_cmd} -chmod 1777 #{mapred_system_cache}/mapred/staging
    #{hadoopfs_cmd} -chown -R mapred #{mapred_system_cache}
  EOH
  user "hdfs"
  group "hdfs"
end

user "#{sampleuser_name}" do
  action :create
end

execute "create_sampleuser_home" do
  command <<-EOH
    #{hadoopfs_cmd} -mkdir -p #{sampleuser_home}
    #{hadoopfs_cmd} -chown #{sampleuser_name} #{sampleuser_home}
  EOH
  user "hdfs"
  group "hdfs"
end
