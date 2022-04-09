module Rudachi
  module Configurable
    def configure
      yield self
    end

    private

    def config_accessor(name, klass:, default:)
      attr_def = <<~EOS
        def self.#{name}; @@#{name}; end
        def self.#{name}=(val); @@#{name} = #{klass}.new(val); end
      EOS
      module_eval(attr_def)
      public_send("#{name}=", default)
    end
  end
end
