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

    def self.included(base)
      raise InvalidInclusion unless base.ancestors.include?(TextParser)
    end

    private

    def input_stream(io)
      io.to_inputstream
    end

    LazyLoad.run_load_hooks(:stream_processor, self)
  end
end
