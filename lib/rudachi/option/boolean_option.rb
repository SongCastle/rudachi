require 'delegate'

module Rudachi
  class Option
    class BooleanOption < Delegator
      def initialize(bool)
        raise ArgumentError, 'must be `false` or `true`' unless bool.is_a?(FalseClass) || bool.is_a?(TrueClass)
        @value = bool
      end

      def __getobj__; @value; end
      def enable?   ; @value; end
      def with_arg? ; false ; end
    end
  end
end
