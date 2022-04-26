require 'rudachi/lazy_load'
require 'rudachi/text_parser'

module Rudachi
  class StreamParser < TextParser
    LazyLoad.on_load(:stream_processor) do
      include StreamProcessor
    end
  end
end
