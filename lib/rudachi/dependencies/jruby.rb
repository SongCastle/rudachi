require 'java'
require 'rudachi/lazy_load'
require Rudachi.jar_path

java_import 'java.lang.System'
java_import 'java.io.PrintStream'
java_import 'java.io.ByteArrayInputStream'
java_import 'java.io.ByteArrayOutputStream'
java_import 'java.nio.charset.StandardCharsets'
java_import 'com.worksap.nlp.sudachi.SudachiCommandLine'

module Rudachi
  module Java
    String                = ::Java::JavaLang::String
    System                = ::Java::JavaLang::System
    PrintStream           = ::Java::JavaIo::PrintStream
    ByteArrayInputStream  = ::Java::JavaIo::ByteArrayInputStream
    ByteArrayOutputStream = ::Java::JavaIo::ByteArrayOutputStream
    UTF_8                 = ::Java::JavaNioCharset::StandardCharsets::UTF_8
    SudachiCommandLine    = ::Java::ComWorksapNlpSudachi::SudachiCommandLine
  end

  module StreamProcessor
    class InvalidInclusion < StandardError; end

    def self.included(mod)
      raise InvalidInclusion unless mod.ancestors.include?(TextParser)
    end

    def parse(io)
      output_stream do |output|
        take_stdin(io.to_inputstream) do
          take_stdout(output) do
            Java::SudachiCommandLine.main(Option.cmds(@opts))
          end
        end
      end
    end
  end

  LazyLoad.run_load_hooks(:stream_processor)
end
