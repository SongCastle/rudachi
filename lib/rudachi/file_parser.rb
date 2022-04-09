require 'rudachi/option/config'
require 'rudachi/loader'

module Rudachi
  class FileParser
    def self.parse(path)
      new.parse(path)
    end

    def initialize(**opts)
      Rudachi.load!

      @output = Java::ByteArrayOutputStream.new
      @opts   = Option.new(opts)
    end

    def parse(path)
      take_stdout do
        Java::SudachiCommandLine.main(
          Option.cmds(@opts).push(Java::String.new(path))
        )
      end
      @output.toString
    end

    private

    def take_stdout
      stdout = Java::System.out
      stream = Java::PrintStream.new(@output)
      Java::System.setOut(stream)

      yield

      Java::System.setOut(stdout)
    end
  end
end
