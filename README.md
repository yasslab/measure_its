# MeasureIts

A wrapper to profiling a whole method body.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'measure_its'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install measure_its

## Usage

```rb
require 'measure_its'
using MeasureIts

# or

require 'measure_its/core_ext'

# define the measure strategy
require 'rblineprof'
MeasureIts.add_strategy(:rblineprof) do |&block|
  puts :begin
  prof = lineprof(/./) { block.call }
  p prof
  puts :end
end

# measure_its method_name, with: [strategy1, strategy2, ...]
class C
  def heavy_job
    # ...
  end
  measure_its :heavy_job, with: [:rblineprof]
end

C.new.heavy_job
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yasslab/measure_its. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MeasureIts project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yasslab/measure_its/blob/master/CODE_OF_CONDUCT.md).
