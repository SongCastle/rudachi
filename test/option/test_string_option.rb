require_relative '../test_helper'

describe Rudachi::Option::StringOption do
  describe '#initialize' do
    it 'returns an instance' do
      expect { Rudachi::Option::StringOption.new('A') }.wont_raise
    end

    describe 'when with `nil`' do
      it 'returns an instance' do
        expect { Rudachi::Option::StringOption.new(nil) }.wont_raise
      end
    end

    describe 'when with an invalid arg' do
      it 'raises `ArgumentError`' do
        err = expect { Rudachi::Option::StringOption.new(-1) }.must_raise
        expect(err.message).must_equal('must be `nil` or `String`')
      end
    end
  end

  describe '#enable?' do
    it 'returns `true`' do
      opt = Rudachi::Option::StringOption.new('A')
      expect(opt.enable?).must_equal(true)
    end

    describe 'when with `nil`' do
      it 'returns `false`' do
        opt = Rudachi::Option::StringOption.new(nil)
        expect(opt.enable?).must_equal(false)
      end
    end
  end

  describe '#with_arg?' do
    it 'always returns `true`' do
      opt = Rudachi::Option::StringOption.new('A')
      expect(opt.with_arg?).must_equal(true)
    end

    describe 'when with `nil`' do
      it 'always returns `true`' do
        opt = Rudachi::Option::StringOption.new(nil)
        expect(opt.with_arg?).must_equal(true)
      end
    end
  end
end
