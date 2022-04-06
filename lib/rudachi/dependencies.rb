require 'java'
java_import 'java.lang.System'
java_import 'java.io.PrintStream'
java_import 'java.io.ByteArrayInputStream'
java_import 'java.io.ByteArrayOutputStream'
java_import 'java.nio.charset.StandardCharsets'

require Rudachi.jar_path
java_import 'com.worksap.nlp.sudachi.SudachiCommandLine'

module Java
  String                = JavaLang::String
  System                = JavaLang::System
  ByteArrayInputStream  = JavaIo::ByteArrayInputStream
  ByteArrayOutputStream = JavaIo::ByteArrayOutputStream
  PrintStream           = JavaIo::PrintStream
  UTF_8                 = JavaNioCharset::StandardCharsets::UTF_8
  SudachiCommandLine    = ComWorksapNlpSudachi::SudachiCommandLine
end
