#
# Cookbook Name:: amazon-ecs-agent
# Recipe:: default
#
# Copyright (C) 2014 Will Salt
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe 'chef-sugar'

# setup docker apt repo
include_recipe 'chef-apt-docker'

# IAM role support for tasks
include_recipe 'sysctl::default'
include_recipe 'iptables::default'
sysctl_param 'net.ipv4.conf.all.route_localnet' do
  value 1
end
iptables_rule 'dnat_80_to_51679' do
  lines [
    '*nat',
    '-A PREROUTING -p tcp -d 169.254.170.2 --dport 80 -j DNAT --to-destination 127.0.0.1:51679'
  ].join("\n")
end
iptables_rule 'redirect_80_to_51679' do
  lines [
    '*nat',
    '-A OUTPUT -d 169.254.170.2 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 51679'
  ].join("\n")
end

# create directories
directory node['amazon-ecs-agent']['log_folder'] do
  mode '0755'
  action :create
end

directory node['amazon-ecs-agent']['data_folder'] do
  mode '0755'
  recursive true
  action :create
end

package "linux-image-extra-#{node['kernel']['release']}" do
  only_if { node['amazon-ecs-agent']['storage_driver'] == 'aufs' }
end

docker_installation_package 'default' do
  version node['amazon-ecs-agent']['docker']['version']
  action :create
end

# create the docker service
docker_service 'default' do
  storage_driver node['amazon-ecs-agent']['storage_driver']
  action [:create, :start]
end

# pull down the latest image
docker_image 'amazon/amazon-ecs-agent'

# start the container and map it to port 8484
docker_container 'amazon-ecs-agent' do
  repo 'amazon/amazon-ecs-agent'
  tag node['amazon-ecs-agent']['tag']
  network_mode 'host'
  env [
    'ECS_LOGFILE=/log/ecs-agent.log',
    "ECS_LOGLEVEL=#{node['amazon-ecs-agent']['log_level']}",
    'ECS_DATADIR=/data',
    'ECS_UPDATE_DOWNLOAD_DIR=/var/cache/ecs',
    "ECS_CLUSTER=#{node['amazon-ecs-agent']['cluster']}",
    "AWS_ACCESS_KEY_ID=#{node['amazon-ecs-agent']['aws_access_key_id']}",
    "AWS_SECRET_ACCESS_KEY=#{node['amazon-ecs-agent']['aws_secret_access_key']}"
  ] + node['amazon-ecs-agent']['docker_additional_env']
  volumes [
    '/var/run/docker.sock:/var/run/docker.sock',
    "#{node['amazon-ecs-agent']['log_folder']}:/log",
    "#{node['amazon-ecs-agent']['data_folder']}:/data",
    "#{node['amazon-ecs-agent']['cache_folder']}:/var/cache/ecs"
  ] + node['amazon-ecs-agent']['docker_additional_binds']
  restart_policy node['amazon-ecs-agent']['restart_policy']
end
