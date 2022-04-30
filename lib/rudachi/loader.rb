module Rudachi
  class UnavailableError < StandardError; end;

  class << self
    def load!
      raise UnavailableError, 'jruby_required' unless jruby?
      require 'rudachi/dependencies'
    end

    private

    def jruby?
      RUBY_PLATFORM == 'java'
    end
  end
end
