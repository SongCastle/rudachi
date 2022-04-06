lib = File.expand_path('../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'rudachi/version'

Gem::Specification.new do |s|
  s.name        = 'rudachi'
  s.version     = Rudachi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses    = 'MIT'
  s.summary     = 'Sudachi wrapper for JRuby'
  s.email       = '-'
  s.homepage    = 'https://github.com/SongCastle/rudachi'
  s.description = 'Sudachi wrapper for JRuby.'
  s.author      = 'SongCastle'

  s.files                 = Dir['lib/**/*', 'README.md']
  s.require_paths         = ['lib']
  s.required_ruby_version = Gem::Requirement.new('>= 2.3')
end
