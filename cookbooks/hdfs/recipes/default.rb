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
mapred_staging_dir = "#{mapred_system_cache}/mapred/staging"
user_dir = "/user"
sampleuser_home = "#{user_dir}/sampleuser"
sampleuser_name = "sampleuser"
tmp_dir = "/tmp"

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
  action :nothing
  command <<-EOH
    #{hadoopfs_cmd} -mkdir -p #{mapred_staging_dir}
    #{hadoopfs_cmd} -chmod -R 1777 #{mapred_staging_dir}
    #{hadoopfs_cmd} -chown -R mapred #{mapred_system_cache}
  EOH
  user "hdfs"
  group "hdfs"
end

user "#{sampleuser_name}" do
  action :create
end

execute "create_user_dir" do
  command <<-EOH
    #{hadoopfs_cmd} -mkdir -p #{user_dir}
    #{hadoopfs_cmd} -chmod -R 777 #{user_dir}
  EOH
  user "hdfs"
  group "hdfs"
end

execute "create_sampleuser_home" do
  command <<-EOH
    #{hadoopfs_cmd} -mkdir -p #{sampleuser_home}
    #{hadoopfs_cmd} -chown #{sampleuser_name} #{sampleuser_home}
  EOH
  user "hdfs"
  group "hdfs"
end

execute "chown_sampleuser_staging" do
  command <<-EOH
    #{hadoopfs_cmd} -mkdir -p #{mapred_staging_dir}/#{sampleuser_name}
    #{hadoopfs_cmd} -chown -R #{sampleuser_name} #{mapred_staging_dir}/#{sampleuser_name}
  EOH
  user "hdfs"
  group "hdfs"
end

execute "create_tmp_dir" do
  command <<-EOH
    #{hadoopfs_cmd} -mkdir -p #{tmp_dir}
    #{hadoopfs_cmd} -chmod -R 777 #{tmp_dir}
  EOH
  user "hdfs"
  group "hdfs"
end
