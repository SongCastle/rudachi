require 'rudachi/file_parser'

module Rudachi
  class TextParser < FileParser
    def parse(text)
      @input = Java::String.new(text)
      take_stdin do
        take_stdout do
          Java::SudachiCommandLine.main(Option.cmds(@opts))
        end
      end
      @output.toString
    end

    private

    def take_stdin
      stdin = Java::System.in
      stream = Java::ByteArrayInputStream.new(@input.getBytes(Java::UTF_8))
      Java::System.setIn(stream)

      yield

      Java::System.setIn(stdin)
    end
  end
end
