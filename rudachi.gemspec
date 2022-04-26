lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'rudachi/loader'
require 'rudachi/version'

Gem::Specification.new do |s|
  s.name        = 'rudachi'
  s.version     = Rudachi::VERSION
  s.licenses    = 'MIT'
  s.summary     = 'A Ruby wrapper for Sudachi'
  s.email       = '-'
  s.homepage    = 'https://github.com/SongCastle/rudachi'
  s.description = 'A Ruby wrapper for Sudachi.'
  s.author      = 'SongCastle'

  s.files                 = Dir['lib/**/*', 'README.md']
  s.require_paths         = ['lib']
  s.required_ruby_version = Gem::Requirement.new('>= 2.3')

  if Rudachi.jruby?
    s.platform = Gem::Platform::CURRENT
  else
    s.platform = Gem::Platform::RUBY
    s.add_dependency('rjb', '>= 1.1.1')
  end
end
