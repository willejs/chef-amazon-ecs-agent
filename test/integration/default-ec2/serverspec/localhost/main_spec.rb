require 'spec_helper'

describe command('sudo docker ps') do
  its(:stdout) { should match(/^.*amazon-ecs-agent.*Up.*/) }
end
