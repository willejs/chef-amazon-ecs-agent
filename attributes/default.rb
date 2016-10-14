default['amazon-ecs-agent']['cluster'] = 'default'

default['amazon-ecs-agent']['docker']['version'] = '1.12.1'
default['amazon-ecs-agent']['tag'] = 'latest' # version of ecs agent to deploy

default['amazon-ecs-agent']['restart_policy'] = 'always'

default['amazon-ecs-agent']['storage_driver'] = 'aufs'

default['amazon-ecs-agent']['docker_additional_binds'] = []
default['amazon-ecs-agent']['docker_additional_env'] = [
  'ECS_ENABLE_TASK_IAM_ROLE=true',
  'ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true'
]

default['amazon-ecs-agent']['log_level'] = 'info'

default['amazon-ecs-agent']['log_folder'] = '/var/log/ecs'
default['amazon-ecs-agent']['data_folder'] = '/var/lib/ecs/data'
default['amazon-ecs-agent']['cache_folder'] = '/var/cache/ecs'

# Primarily intended for testing - use IAM in production
default['amazon-ecs-agent']['aws_access_key_id'] = nil
default['amazon-ecs-agent']['aws_secret_access_key'] = nil
