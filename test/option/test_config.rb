require_relative '../test_helper'

describe Rudachi::Option do
  describe '.configure' do
    it 'set "p" option as default' do
      Rudachi::Option.configure do |config|
        config.p = 'path/to/your_root_sudachi'
      end

      expect(Rudachi::Option.p).must_be(:==, 'path/to/your_root_sudachi')
    end

    describe 'when an invaid configuration' do
      describe 'when `StringOption`' do
        it 'raises `ArgumentError`' do
          Rudachi::Option.configure do |config|
            err = expect {
              config.p = false
            }.must_raise(ArgumentError)
            expect(err.message).must_equal('must be `nil` or `String`')
          end
        end
      end

      describe 'when `BooleanOption`' do
        it 'raises `ArgumentError`' do
          Rudachi::Option.configure do |config|
            err = expect {
              config.a = 'a'
            }.must_raise(ArgumentError)
            expect(err.message).must_equal('must be `false` or `true`')
          end
        end
      end
    end
  end

  describe '.cmds' do
    before do
      Rudachi::Option.configure do |config|
        config.p = 'path/to/your_root_sudachi'
      end
    end

    it 'returns an array for command line' do
      expect(Rudachi::Option.cmds).must_equal(['-p', 'path/to/your_root_sudachi'])
    end

    describe 'when with args' do
      it 'returns an array for command line' do
        expect(Rudachi::Option.cmds(
          Rudachi::Option.new(a: false, d: true, m: 'A', r: nil)
        ).sort).must_equal(['-p', 'path/to/your_root_sudachi', '-m', 'A', '-d'].sort)
      end

      describe 'when overwrite the default args' do
        it 'returns an array for command line' do
          p_opt = 'path/to/your_root_sudachi'.reverse
          expect(
            Rudachi::Option.cmds(Rudachi::Option.new(p: p_opt))
          ).must_equal(['-p', p_opt])
        end
      end
    end
  end

  describe '#initialize' do
    it 'returns an instance' do
      expect { Rudachi::Option.new }.wont_raise
    end

    describe 'when with some valid args' do
      it 'returns an instance' do
        opts = expect { Rudachi::Option.new(m: 'A', a: false) }.wont_raise
        expect(opts.get(:m)).must_be(:==, 'A')
        expect(opts.get(:a)).must_be(:==, false)
      end
    end

    describe 'when with an invalid arg' do
      it 'raises `ArgumentError`' do
        err = expect { Rudachi::Option.new(m: 'A', a: -1) }.must_raise(ArgumentError)
        expect(err.message).must_equal('"a" must be `false` or `true`')
      end
    end

    describe 'when with an unknown option' do
      it 'raises `ArgumentError`' do
        err = expect { Rudachi::Option.new(x: -1) }.must_raise(ArgumentError)
        expect(err.message).must_equal('unknown option "x"')
      end
    end
  end

  describe '#get' do
    it 'returns a target option' do
      opts = Rudachi::Option.new(m: 'A')
      expect(opts.get(:m)).must_be(:==, 'A')
    end

    describe 'when with a block' do
      it 'returns a target option' do
        opts = Rudachi::Option.new(m: 'A')

        expect(
          opts.get(:m) { Rudachi::Option::StringOption.new('B') }
        ).must_be(:==, 'A')
      end

      describe 'when the target option doesn\'t exist' do
        it 'returns a option that given the block' do
          opts = Rudachi::Option.new

          expect(
            opts.get(:m) { Rudachi::Option::StringOption.new('B') }
          ).must_be(:==, 'B')
        end
      end
    end

    describe 'when the target option doesn\'t exist' do
      it 'returns `nil`' do
        opts = Rudachi::Option.new
        expect(opts.get(:m)).must_be_nil
      end
    end
  end
end
