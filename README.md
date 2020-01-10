# SortableForRails

## Description
Simple gem for sorting data in HTML tables

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sortable-for-rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sortable-for-rails

## Usage

```
class User < ApplicationRecord
  include Sortable::Model

  sortable :id, :updated_at, :email
  sortable :profile_name, -> { joins(:profile) }, column: "profiles.name"
  sortable :status, method: :sortable_status

  # we can sort in memory also if needed (for data not stored directly in DB)
  # just remember on performance impact
  def self.sortable_status(direction)
    results = all.sort_by { |user| user.status }
    results.reverse! if direction == :desc
    results
  end

end
```

In Views

```
<th><%= sortable :email, default: true %></th>
<th><%= sortable :updated_at, direction: :desc %></th>
<th>
  <%= sortable :profile_name do %>
    Custom label
  <% end %>
</th>
```
If you want customize how arrows are generated copy `views/sortable/_label.html.erb`
and change how you want.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/madmax/sortable-for-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SortableForRails project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/madmax/sortable-for-rails/blob/master/CODE_OF_CONDUCT.md).
