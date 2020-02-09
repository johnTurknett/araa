# App
ARAA (ActiveRecord Auto Associate) is a Gem that allows you to dynamically build 
your models associations without having to explicitly define them.

It does this by inspecting the defined schema via ActiveRecord and populates 
an initializer file. This file contains class declarations of your models that 
use re-open them and defines ActiveRecord relations.

This is generated via a Rake task.

## Usage
`rake araa:generate`

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'araa'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install araa
```

## Contributing
Please feel free to contribute.

At the moment, I don't know how to test this... If anyone has experience 
testing the effects of a plugins effect on the dummy application I would 
love the insight.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Future

- [ ] Tie into Migration event and rerun
