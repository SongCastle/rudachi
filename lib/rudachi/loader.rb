module Rudachi
  class << self
    def load!
      if jruby?
        require 'rudachi/dependencies/jruby'
      else
        require 'rudachi/dependencies/ruby'
      end
    end

    def jruby?
      RUBY_PLATFORM == 'java'
    end
  end
end
