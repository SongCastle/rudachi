module Rudachi
  class Option
    class StringOption < Delegator
      def initialize(str)
        raise ArgumentError, 'must be `nil` or `String`' unless str.nil? || str.is_a?(String)
        @value = str
      end

      def __getobj__; @value; end
      def enable?; !!@value; end
      def with_arg?; true; end
    end
  end
end
