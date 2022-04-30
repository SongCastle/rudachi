module Rudachi
  module LazyLoad
    @@hooks = {}

    class << self
      def on_load(name, &block)
        @@hooks[name] ||= []
        @@hooks[name] << block
      end

      def run_load_hooks(name, mod)
        @@hooks[name]&.each do |hook|
          hook.call(mod)
        end
      end
    end
  end
end
