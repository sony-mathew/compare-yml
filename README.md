# Compare::YML

This library can be used to compare two yml or json files to understand the differences in keys of both files. This library supports comparison of deeply nested keys also.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'compare-yml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install compare-yml

## Usage

The usage of this gem is pretty simple. You don't need to have this in your gemfile to use this. An executable is already included.

So after doing `gem install compare-yml`, you can directly type in 

```
compare_yml source_file target_file
```
in your terminal/command-prompt.

This library is designed to work with comparing both yaml and json files. An example usage in a rails translation situation would be: 

```
compare_yml config/locales/en.yml config/locales/de.yml
```

This will show you the keys which are missing from `en.yml` compared to `de.yml` and vice versa. The comparision is two way meaning, we will compare `en.yml` keys with respect to `de.yml` keys and also compare `de.yml` keys with respect to `en.yml`.

An example usage for people using translation in react app would be :

```
compare_yml public/static/locales/fr.json public/static/locales/en.json
```

You can use this for comparing translation files, as well as for any yml or json files for that matter. Do not get fooled by the examples.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/compare-yml. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Compare::Yml project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/sony-mathew/compare-yml/blob/master/CODE_OF_CONDUCT.md).
