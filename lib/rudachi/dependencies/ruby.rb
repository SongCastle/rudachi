require 'rjb'
require 'rudachi/lazy_load'

Rjb::load(Rudachi.jar_path.to_s)

module Rudachi
  module Java
    String                = Rjb::import('java.lang.String')
    System                = Rjb::import('java.lang.System')
    PrintStream           = Rjb::import('java.io.PrintStream')
    ByteArrayInputStream  = Rjb::import('java.io.ByteArrayInputStream')
    ByteArrayOutputStream = Rjb::import('java.io.ByteArrayOutputStream')
    UTF_8                 = Rjb::import('java.nio.charset.StandardCharsets').UTF_8
    SudachiCommandLine    = Rjb::import('com.worksap.nlp.sudachi.SudachiCommandLine')
  end

  module StreamProcessor
    class InvalidInclusion < StandardError; end

    def self.included(mod)
      raise InvalidInclusion unless mod.ancestors.include?(TextParser)
    end

    def parse(io)
      r, w = IO.pipe

      Thread.start do
        while data = io.gets
          w.puts(data)
        end
        w.close
      end

      ret = []
      while data = r.gets
        ret << super(data).strip
      end

      r.close

      ret.join(?\n)
    end

    LazyLoad.run_load_hooks(:stream_processor)
  end
end
