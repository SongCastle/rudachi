require 'rudachi/option/config'
require 'rudachi/loader'

module Rudachi
  class FileParser
    def self.parse(path)
      new.parse(path)
    end

    def initialize(**opts)
      Rudachi.load!
      @opts = Option.new(opts)
    end

    def parse(path)
      output_stream do |output|
        take_stdout(output) do
          Java::SudachiCommandLine.main(
            Option.cmds(@opts).push(path)
          )
        end
      end
    end

    private

    def take_stdout(output)
      stdout = Java::System.out

      Java::System.setOut(output)
      yield
      Java::System.setOut(stdout)
    end

    def output_stream
      Java::ByteArrayOutputStream.new.tap do |output|
        yield Java::PrintStream.new(output)
      end.toString
    end
  end
end
