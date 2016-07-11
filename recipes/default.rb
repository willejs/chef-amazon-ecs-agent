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

# create the default log folder
directory node['amazon-ecs-agent']['log_folder'] do
  mode 0755
  action :create
end

directory node['amazon-ecs-agent']['data_folder'] do
  mode 0755
  recursive true
  action :create
end

package "linux-image-extra-#{node['kernel']['release']}" do
  only_if { node['amazon-ecs-agent']['storage_driver'] == 'aufs' }
end

docker_installation_binary 'default' do
  version '1.10.3'
  action :create
end

# create the docker service
docker_service 'default' do
  storage_driver node['amazon-ecs-agent']['storage_driver']
  action [:create, :start]
end

# pull down the latest image
docker_image 'amazon/amazon-ecs-agent'

environment_variables = [ 
    'ECS_DATADIR=/data',
    'ECS_LOGFILE=/log/ecs-agent.log',
    "ECS_LOGLEVEL=#{node['amazon-ecs-agent']['log_level']}",
    "ECS_CLUSTER=#{node['amazon-ecs-agent']['cluster']}"
  ] + node['amazon-ecs-agent']['docker_additional_envs']

# use the env file to trigger a redeploy on changes
file '/etc/default/ecs-agent' do
  action :create
  owner 'root'
  group 'root'
  mode '0644'
  content environment_variables.join('\n')
  notifies :redeploy, 'docker_container[amazon-ecs-agent]'
end

# start the container and map it to port 8484
docker_container 'amazon-ecs-agent' do
  repo 'amazon/amazon-ecs-agent'
  port '51678:51678'
  tag 'latest'

  env environment_variables

  binds [
    "#{node['amazon-ecs-agent']['log_folder']}:/log",
    '/var/run/docker.sock:/var/run/docker.sock',
    "#{node['amazon-ecs-agent']['data_folder']}:/data"
  ] + node['amazon-ecs-agent']['docker_additional_binds']
end
