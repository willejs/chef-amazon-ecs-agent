# Encoding: utf-8

source 'https://rubygems.org'

gem 'berkshelf'

if ENV['CI']
  gem 'serverspec', '>= 2.0'
  gem 'vagrant-wrapper'
  gem 'chef', '>= 11.8'
  gem 'rake', '>= 10.2'
  gem 'rubocop', '>= 0.23'
  gem 'foodcritic', '>= 4.0'
  gem 'chefspec', '>= 4.0'
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'nokogiri', '>= 1.6.4.1'
else
  gem 'chef'
  gem 'rake'
  gem 'rubocop'
  gem 'foodcritic'
  gem 'chefspec'
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
  gem 'kitchen-ec2', github: 'test-kitchen/kitchen-ec2'
end
