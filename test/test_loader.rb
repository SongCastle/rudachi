require_relative 'test_helper'

describe Rudachi do
  describe '.load!' do
    it 'loads Sudachi dependencies' do
      expect { Rudachi.load! }.wont_raise
    end
  end

  describe '.jruby?' do
    subject { Rudachi.jruby? }

    describe '`RUBY_PLATFORM` is "java"' do
      it 'returns `true`' do
        stub_const('RUBY_PLATFORM', 'java') do
          expect(subject).must_equal(true)
        end
      end
    end

    describe '`RUBY_PLATFORM` is not "java"' do
      it 'returns `false`' do
        stub_const('RUBY_PLATFORM', 'x86_64-linux') do
          expect(subject).must_equal(false)
        end
      end
    end
  end
end
