require 'rudachi/configurable'
require 'rudachi/option/boolean_option'
require 'rudachi/option/string_option'

module Rudachi
  class Option
    extend Configurable

    # @see https://github.com/WorksApplications/Sudachi#options
    config_accessor :r,  klass: StringOption,  default: nil
    config_accessor :s,  klass: StringOption,  default: nil
    config_accessor :p,  klass: StringOption,  default: nil
    config_accessor :m,  klass: StringOption,  default: nil
    config_accessor :o,  klass: StringOption,  default: nil
    config_accessor :a,  klass: BooleanOption, default: false
    config_accessor :d,  klass: BooleanOption, default: false
    config_accessor :t,  klass: BooleanOption, default: false
    config_accessor :ts, klass: BooleanOption, default: false
    config_accessor :f,  klass: BooleanOption, default: false
    config_accessor :h,  klass: BooleanOption, default: false

    def self.cmds(opts=Option.new)
      class_variables.each_with_object([]) do |name, flags|
        key = name[2..-1].to_sym
        opt = opts.get(key) { class_variable_get(name) }
        next unless opt&.enable?
        flags << "-#{key}"
        flags << opt.to_s if opt.with_arg?
      end
    end

    def initialize(**hash)
      @opts = hash.each_with_object({}) do |(key, val), _hash|
        raise ArgumentError, %{unknown option "#{key}"} unless self.class.class_variable_defined?("@@#{key}")
        begin
          _hash[key.to_sym] = self.class.class_variable_get("@@#{key}").class.new(val)
        rescue ArgumentError => e
          raise ArgumentError, %{"#{key}" #{e.message}}
        end
      end
    end

    def get(key, &block)
      @opts.key?(key) ? @opts[key] : block&.call
    end
  end
end
