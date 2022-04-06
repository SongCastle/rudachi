require 'rudachi/configurable'

module Rudachi
  extend Configurable

  config_accessor :jar_path,  default: '/usr/java/lib/sudachi.jar'

  module Option
    extend Configurable

    # @see https://github.com/WorksApplications/Sudachi#options
    config_accessor :r,  default: nil
    config_accessor :s,  default: nil
    config_accessor :p,  default: '/usr/java/lib'
    config_accessor :m,  default: 'C'
    config_accessor :o,  default: nil
    config_accessor :t,  default: nil
    config_accessor :ts, default: nil
    config_accessor :a,  default: nil
    config_accessor :f,  default: nil
    config_accessor :d,  default: nil
    config_accessor :h,  default: nil

    def self.cmds(opts)
      class_variables.each_with_object([]) do |name, flags|
        key = name.to_s.delete('@@')
        val = opts[key] || opts[key.to_sym] || class_variable_get(name) or next
        flags << "-#{key}" << val.to_s
      end
    end
  end
end
