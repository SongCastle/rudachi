require 'rudachi/configurable'
require 'rudachi/option/string_option'

module Rudachi
  extend Configurable

  config_accessor :jar_path, klass: Option::StringOption, default: '/usr/java/lib/sudachi.jar'
end
