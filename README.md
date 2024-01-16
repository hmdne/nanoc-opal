# nanoc-opal

This provides a filter that allows [Nanoc](https://nanoc.app) to process content via [Opal](https://opalrb.com).

This gem is based on nanoc's own nanoc-dart-sass.

## Installation

Add `nanoc-opal` to the `nanoc` group of your Gemfile:

```ruby
group :nanoc do
  gem 'nanoc-opal'
end
```

## Usage

Call the `:opal` filter. For example:

```ruby
require "nanoc-opal"
compile '/script.rb' do
  filter :opal

  write item.identifier.without_ext + '.js'
end
```

Options passed to this filter will be passed on to Opal. For example:

```ruby
filter :opal, arity_check: true
```

See `example` directory for a sample how to use Nanoc with Opal and Opal-Browser.
