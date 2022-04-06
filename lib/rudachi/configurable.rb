module Rudachi
  module Configurable
    def configure
      yield self
    end

    private

    def config_accessor(name, default: nil)
      attr_def = <<~EOS
        def self.#{name}; @@#{name}; end
        def self.#{name}=(val); @@#{name} = val; end
      EOS
      module_eval(attr_def)
      class_variable_set("@@#{name}", default)
    end
  end
end
