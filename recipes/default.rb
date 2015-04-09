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

include_recipe 'docker'

directory node['amazon-ecs-agent']['log_folder'] do
	owner 'docker'
	group 'docker'
	mode 0755
	action :create
end


docker_container 'ecs-agent' do
  image 'amazon/amazon-ecs-agent'
  env ["ECS_LOGFILE=/log/ecs-agent.log",
  	   "ECS_LOGLEVEL=#{node['amazon-ecs-agent']['log_level']}",
  	   "ECS_CLUSTER=#{node['amazon-ecs-agent']['cluster']}",
  	   "AWS_ACCESS_KEY_ID=#{node['amazon-ecs-agent']['aws_access_key_id']}",
  	   "AWS_SECRET_ACCESS_KEY=#{node['amazon-ecs-agent']['aws_secret_access_key']}"
    ]
  volume ["#{node['amazon-ecs-agent']['log_folder']}:/log", '/var/run/docker.sock:/var/run/docker.sock']
  port '51678:51678'
  cmd_timeout 120
  detach true
  tag node['amazon-ecs-agent']['tag']
end