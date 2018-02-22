# FastStats

| Travis CI|
|----------|
| [![Build Status](https://travis-ci.org/kyle-rader/fast_stats.svg?branch=master)](https://travis-ci.org/kyle-rader/fast_stats) |

Welcome to FastStats!
This gem is for computing stats in an efficient manner. Right now it just manages a collection of arithmetic and geometric means to help reduce the [data clump code smell](https://sourcemaking.com/refactoring/smells/data-clumps).

To experiment with the gem, clone it, run `bundle install` and then `bin/console` for an interactive [pry](http://pryrepl.org/) session (A great Ruby REPL).


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fast_stats'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fast_stats

## Usage

The current main usage of `FastStats` is to track and build means while iterating over data sets.

Example: Let's say you want to get some means for social media posts.

You can track several metrics with `FastStats::Means`:

```ruby
# Say you have some PostFetcher that is an enumerator for your posts.
means = FastStats::Means.new

PostFetcher.each do |post|
   # do stuff with post
   means.add "likes", post["like_count"]
   means.add "comments", post["share_count"]
end

means.summary
# =>
#{
#   "foo_arithmetic"=>4.888888888888889,
#   "foo_geometric"=>3.345423581422162,
#   "bar_arithmetic"=>13.636363636363637,
#   "bar_geometric"=>7.1824970648723765
#}

```

You can track an individual metric with `FastStats::Mean`:

```ruby
mean = FastStats::Mean.new name: "foobar"
10.times { |i| mean << i }  # or mean.add(i)

puts mean.arithmetic
# => 4.5
puts mean.geometric
# => 3.597297064377001
puts mean.summary
# => {
#   "foobar_arithmetic"=>4.5,
#   "foobar_geometric"=>3.597297064377001
#   }
```

## Change Log

Changes and plans for future changes can be found in [the Change Log](./CHANGE_LOG.md).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fast_stats. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the FastStats project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fast_stats/blob/master/CODE_OF_CONDUCT.md).
