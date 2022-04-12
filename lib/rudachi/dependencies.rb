require 'java'
java_import 'java.lang.System'
java_import 'java.io.PrintStream'
java_import 'java.io.ByteArrayInputStream'
java_import 'java.io.ByteArrayOutputStream'
java_import 'java.nio.charset.StandardCharsets'

require Rudachi.jar_path
java_import 'com.worksap.nlp.sudachi.SudachiCommandLine'

module Rudachi
  module Java
    System                = ::Java::JavaLang::System
    ByteArrayInputStream  = ::Java::JavaIo::ByteArrayInputStream
    ByteArrayOutputStream = ::Java::JavaIo::ByteArrayOutputStream
    PrintStream           = ::Java::JavaIo::PrintStream
    UTF_8                 = ::Java::JavaNioCharset::StandardCharsets::UTF_8
    SudachiCommandLine    = ::Java::ComWorksapNlpSudachi::SudachiCommandLine
  end
end
