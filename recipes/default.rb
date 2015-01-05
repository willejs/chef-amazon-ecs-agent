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

directory node['ecs']['log_folder'] do
	owner 'docker'
	group 'docker'
	mode 0755
	action :create
end


docker_container 'ecs-agent' do
  image 'amazon/amazon-ecs-agent'
  env ["ECS_LOGFILE=#{node['ecs']['log_folder']}/ecs.log",
  	   "ECS_LOGLEVEL=#{node['ecs']['log_level']}",
  	   "ECS_CLUSTER=#{node['ecs']['cluster']}",
  	   "AWS_ACCESS_KEY_ID=#{node['ecs']['aws_access_key_id']}",
  	   "AWS_SECRET_ACCESS_KEY=#{node['ecs']['aws_secret_access_key']}"
    ]
end