require_relative '../test_helper'

describe Rudachi::Option::BooleanOption do
  describe '#initialize' do
    it 'returns an instance' do
      expect { Rudachi::Option::BooleanOption.new(false) }.wont_raise
    end

    describe 'when with an invalid arg' do
      it 'raises `ArgumentError`' do
        err = expect { Rudachi::Option::BooleanOption.new(-1) }.must_raise
        expect(err.message).must_equal('must be `false` or `true`')
      end
    end
  end

  describe '#enable?' do
    it 'returns `false`' do
      opt = Rudachi::Option::BooleanOption.new(false)
      expect(opt.enable?).must_equal(false)
    end

    describe 'when with `true`' do
      it 'returns `true`' do
        opt = Rudachi::Option::BooleanOption.new(true)
        expect(opt.enable?).must_equal(true)
      end
    end
  end

  describe '#with_arg?' do
    it 'always returns `false`' do
      opt = Rudachi::Option::BooleanOption.new(false)
      expect(opt.with_arg?).must_equal(false)
    end

    describe 'when with `true`' do
      it 'always returns `false`' do
        opt = Rudachi::Option::BooleanOption.new(true)
        expect(opt.with_arg?).must_equal(false)
      end
    end
  end
end
