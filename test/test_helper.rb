lib = File.expand_path('../../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'minitest/autorun'
require 'rudachi'
require 'rudachi/version'

MiniTest::Spec.before do
  Rudachi.configure do |config|
    config.jar_path = File.expand_path('bin/sudachi/sudachi-0.5.3.jar', Dir.pwd)
  end

  Rudachi::Option.configure do |config|
    config.p = File.expand_path('bin/sudachi', Dir.pwd)
  end
end
