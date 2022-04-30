require_relative 'test_helper'

describe Rudachi do
  describe '.load!' do
    it 'loads Sudachi dependencies' do
      expect { Rudachi.load! }.wont_raise
    end

    describe 'when JRuby is not available' do
      it 'raises `UnavailableError`' do
        stub_const('RUBY_PLATFORM','x86_64-linux') do
          err = expect { Rudachi.load! }.must_raise(Rudachi::UnavailableError)
          expect(err.message).must_equal('jruby_required')
        end
      end
    end
  end
end
