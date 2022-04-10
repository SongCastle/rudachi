module Rudachi
  module Configurable
    def configure
      yield self
    end

    private

    def config_accessor(name, klass:, default:)
      module_eval <<~EOS
        def self.#{name}; @@#{name}; end
        def self.#{name}=(val); @@#{name} = #{klass}.new(val); end
      EOS
      public_send("#{name}=", default)
    end
  end
end
