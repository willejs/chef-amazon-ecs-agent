name 'amazon-ecs-agent'
maintainer 'Will Salt'
maintainer_email 'williamejsalt@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures amazon-ecs-agent'
long_description 'Installs/Configures amazon-ecs-agent'
version '1.2.1'

supports 'ubuntu'

depends 'docker', '~> 2.3.1'
depends 'chef-sugar'
depends 'apt'
