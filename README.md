# Bond
[![Circle CI](https://circleci.com/gh/jwg2s/bond-ruby/tree/develop.svg?style=shield)](https://circleci.com/gh/jwg2s/bond-ruby/tree/develop)
[![Code Climate](https://codeclimate.com/github/jwg2s/bond-ruby/badges/gpa.svg)](https://codeclimate.com/github/jwg2s/bond-ruby)
[![Test Coverage](https://codeclimate.com/github/jwg2s/bond-ruby/badges/coverage.svg)](https://codeclimate.com/github/jwg2s/bond-ruby/coverage)

Full documentation of the Bond API can be found here: http://docs.bond.apiary.io.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bond'
```

And then execute:

```
bundle
```

Or install it yourself with:

```
gem install bond
```

## Usage

### Set your API Key

```
Bond.api_key = 'XXX'
```

### Fetch your Account

```
Bond::Account.new
```

### More usages
Please view the specs to find examples of how the various classes can be used together.

## Contributing

If you would like to contribute, please ensure any new functionality or modified existing functionality is well tested with automated tests.  Open a pull request to this repository and I will review it and make sure it is either accepted or rejected within a reasonable time.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

