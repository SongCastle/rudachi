require 'rudachi/text_parser'

module Rudachi
  class StreamParser < TextParser
    private

    def input_stream(stream)
      stream.to_inputstream
    end
  end
end
