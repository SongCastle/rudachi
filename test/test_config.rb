require_relative 'test_helper'

describe Rudachi do
  describe '.configure' do
    it 'set a JAR path as default' do
      Rudachi.configure do |config|
        config.jar_path = 'path/to/your_sudachi.jar'
      end

      expect(Rudachi.jar_path).must_be(:==, 'path/to/your_sudachi.jar')
    end

    describe 'when an invaid configuration' do
      it 'raises `ArgumentError`' do
        Rudachi.configure do |config|
          err = expect {
            config.jar_path = false
          }.must_raise(ArgumentError)
          expect(err.message).must_equal('must be `nil` or `String`')
        end
      end
    end
  end
end
