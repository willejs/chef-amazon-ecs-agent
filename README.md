# amazon-ecs-agent-cookbook

[![Build Status](https://travis-ci.org/willejs/chef-amazon-ecs-agent.svg?branch=master)](https://travis-ci.org/willejs/chef-amazon-ecs-agent)

This is a work in progress, but currently works

This cookbook sets up amazon-ecs-agent into a docker container on ubuntu.
You can run it in test kitchen with the default-ecs suite, and relevant environment variabes, and perhaps a kitchen local.yml for vpc settings (subnet_id, availability_zone, security_group_ids, interface) if needed.

## Supported Platforms

Ubuntu 12.04
Ubuntu 14.04

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>node['amazon-ecs-agent']['log_folder']</tt></td>
    <td>String</td>
    <td>the log folder for the host</td>
    <td><tt>/var/log/ecs</tt></td>
  </tr>
  <tr>
    <td><tt>node['amazon-ecs-agent']['log_level']</tt></td>
    <td>String</td>
    <td>the log level for the agent</td>
    <td><tt>info</td>
  </tr>
  <tr>
    <td><tt>node['amazon-ecs-agent']['cluster']</tt></td>
    <td>String</td>
    <td>the ecs cluster name to attach to</td>
    <td><tt>default</tt></td>
  </tr>
  <tr>
    <td><tt>node['amazon-ecs-agent']['aws_access_key_id']</tt></td>
    <td>String</td>
    <td>Your aws access key with ecs privs</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>node['amazon-ecs-agent']['aws_secret_access_key']</tt></td>
    <td>String</td>
    <td>The secret access key</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

## Usage

### amazon-ecs-agent::default

Include `amazon-ecs-agent` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[amazon-ecs-agent::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Will Salt (<williamejsalt@gmail.com>)
