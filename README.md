# amazon-ecs-agent-cookbook

This is a work in progress!
===========================
This cookbook sets up amazon-ecs-agent into a docker container on ubuntu.

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
    <td><tt>['amazon-ecs-agent']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
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

Author:: Will Salt (<will@crowdsurge.com>)
