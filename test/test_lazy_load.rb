require_relative 'test_helper'

describe Rudachi::LazyLoad do

  describe '.on_load' do
    it 'registers a hook' do
      check = 0

      Class.new do
        Rudachi::LazyLoad.on_load(:anonymous) do
          check = 1
        end
      end

      hooks = Rudachi::LazyLoad.class_variable_get(:@@hooks)
      expect(hooks).must_be_kind_of(Hash)
      expect(hooks[:anonymous]).must_be_kind_of(Array)
      expect(hooks[:anonymous].size).must_equal(1)
      expect(hooks[:anonymous][0]).must_be_kind_of(Proc)

      hooks[:anonymous][0].call
      expect(check).must_equal(1)
    end
  end

  describe '.run_load_hooks' do
    it 'runs a registered hook' do
      check = 0

      Class.new do
        Rudachi::LazyLoad.on_load(:anonymous) do
          check = 1
        end
      end

      Module.new do
        Rudachi::LazyLoad.run_load_hooks(:anonymous)
      end

      expect(check).must_equal(1)
    end
  end
end
