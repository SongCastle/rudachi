module Rudachi
  module LazyLoad
    @@hooks = {}

    class << self
      def on_load(name, &block)
        @@hooks[name] ||= []
        @@hooks[name] << block
      end

      def run_load_hooks(name)
        @@hooks[name]&.each(&:call)
      end
    end
  end
end
