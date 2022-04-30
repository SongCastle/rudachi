require 'rudachi/lazy_load'
require 'rudachi/text_parser'

module Rudachi
  class StreamParser < TextParser
    LazyLoad.on_load(:stream_processor) do |mod|
      include mod
    end
  end
end
