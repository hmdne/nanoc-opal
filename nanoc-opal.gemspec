# frozen_string_literal: true

require_relative 'lib/nanoc/opal/version'

Gem::Specification.new do |s|
  s.name        = 'nanoc-opal'
  s.version     = Nanoc::Opal::VERSION
  s.homepage    = 'https://github.com/hmdne/nanoc-opal/'
  s.summary     = 'Opal filter for Nanoc'
  s.description = 'Provides an :opal filter for Nanoc'
  s.author      = 'hmdne'
  s.license     = 'MIT'

  s.files         = ['NEWS.md', 'README.md'] + Dir['lib/**/*.rb']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.7'

  s.add_runtime_dependency('nanoc-core', '~> 4.12')
  s.add_runtime_dependency('opal', '~> 1.8')
  s.metadata = {
    'rubygems_mfa_required' => 'true',
    'source_code_uri' => "https://github.com/hmdne/nanoc-opal/tree/#{s.name}-v#{s.version}/#{s.name}",
  }
end
