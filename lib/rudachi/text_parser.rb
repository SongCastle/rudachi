require 'rudachi/file_parser'

module Rudachi
  class TextParser < FileParser
    def parse(text)
      output_stream do |output|
        take_stdin(input_stream(text)) do
          take_stdout(output) do
            Java::SudachiCommandLine.main(Option.cmds(@opts))
          end
        end
      end
    end

    private

    def take_stdin(input)
      stdin = Java::System.in

      Java::System.setIn(input)
      yield
      Java::System.setIn(stdin)
    end

    def input_stream(text)
      Java::ByteArrayInputStream.new(
        text.to_java.getBytes(Java::UTF_8)
      )
    end
  end
end
