lib = File.expand_path('../../lib', __FILE__)
$:.unshift(lib) unless $:.include?(lib)

require 'minitest/autorun'
require 'rudachi'
require 'rudachi/version'

module MiniTest
  module Assertions
    def refute_raises(msg = nil, &block)
      flunk "assert_raises requires a block to capture errors." unless block

      msg = message(msg) do
        "Expected #{block} to not be raised any exception.\n"
      end

      ret =
        begin
          yield
        rescue Minitest::Assertion, SignalException, SystemExit
          raise
        rescue Exception => e
          flunk proc {
            exception_details(e, "#{msg.call}#{mu_pp(block)} exception expected, not")
          }
          return e
        end

      pass
      ret
    end
  end

  module Expectations
    infect_an_assertion :refute_raises, :wont_raise, :block
  end
end

Minitest::Spec.before do
  Rudachi.configure do |config|
    config.jar_path = File.expand_path('bin/sudachi/sudachi-0.5.3.jar', Dir.pwd)
  end

  Rudachi::Option.configure do |config|
    config.p = File.expand_path('bin/sudachi', Dir.pwd)
  end
end
