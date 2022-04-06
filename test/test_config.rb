require_relative 'test_helper'

describe Rudachi do
  describe '.configure' do
    it 'set a JAR path as default' do
      Rudachi.configure do |config|
        config.jar_path = 'path/to/your_sudachi.jar'
      end

      expect(Rudachi.jar_path).must_equal('path/to/your_sudachi.jar')
    end
  end
end

describe Rudachi::Option do
  describe '.configure' do
    it 'set "p" option as default' do
      Rudachi::Option.configure do |config|
        config.p = 'path/to/your_root_sudachi'
      end

      expect(Rudachi::Option.p).must_equal('path/to/your_root_sudachi')
    end
  end
end
