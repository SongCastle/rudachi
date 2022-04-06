require_relative 'test_helper'

describe Rudachi::TextParser do
  describe '.parse' do
    it 'returns analyzed words' do
      ret = Rudachi::TextParser.parse('東京都へ行く')

      expect(ret).must_be_kind_of(String)
      expect(ret.split(?\n)).must_equal([
        "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都",
        "へ\t助詞,格助詞,*,*,*,*\tへ",
        "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
        "EOS"
      ])
    end

    describe 'when with "o" option' do
      before do
        Rudachi::Option.configure do |config|
          config.o = './result.txt'
        end
      end

      after do
        File.delete('./result.txt')
        Rudachi::Option.configure do |config|
          config.o = nil
        end
      end

      it 'writes analyzed words to a output file' do
        ret = Rudachi::TextParser.parse('東京都へ行く')

        expect(ret).must_equal("")
        expect(File.exist?('./result.txt')).must_equal(true)
        output = File.read('./result.txt')
        expect(output.split(?\n)).must_equal([
          "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都",
          "へ\t助詞,格助詞,*,*,*,*\tへ",
          "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
          "EOS"
        ])
      end
    end

    describe 'when with "m" option' do
      before do
        Rudachi::Option.configure do |config|
          config.m = 'A'
        end
      end

      after do
        Rudachi::Option.configure do |config|
          config.m = 'C'
        end
      end

      it 'returns analyzed words by mode "A"' do
        ret = Rudachi::TextParser.parse('東京都へ行く')

        expect(ret).must_be_kind_of(String)
        expect(ret.split(?\n)).must_equal([
          "東京\t名詞,固有名詞,地名,一般,*,*\t東京",
          "都\t名詞,普通名詞,一般,*,*,*\t都",
          "へ\t助詞,格助詞,*,*,*,*\tへ",
          "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
          "EOS"
        ])
      end
    end
  end

  describe '#parse' do
    it 'returns analyzed words' do
      ret = Rudachi::TextParser.new.parse('東京都へ行く')

      expect(ret).must_be_kind_of(String)
      expect(ret.split(?\n)).must_equal([
        "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都",
        "へ\t助詞,格助詞,*,*,*,*\tへ",
        "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
        "EOS"
      ])
    end

    describe 'when with "o" option' do
      after { File.delete('./result.txt') }

      it 'writes analyzed words to a output file' do
        ret = Rudachi::TextParser.new(o: './result.txt').parse('東京都へ行く')

        expect(ret).must_equal("")
        expect(File.exist?('./result.txt')).must_equal(true)
        output = File.read('./result.txt')
        expect(output.split(?\n)).must_equal([
          "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都",
          "へ\t助詞,格助詞,*,*,*,*\tへ",
          "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
          "EOS"
        ])
      end
    end

    describe 'when with "m" option' do
      it 'returns analyzed words by mode "A"' do
        ret = Rudachi::TextParser.new(m: 'A').parse('東京都へ行く')

        expect(ret).must_be_kind_of(String)
        expect(ret.split(?\n)).must_equal([
          "東京\t名詞,固有名詞,地名,一般,*,*\t東京",
          "都\t名詞,普通名詞,一般,*,*,*\t都",
          "へ\t助詞,格助詞,*,*,*,*\tへ",
          "行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く",
          "EOS"
        ])
      end
    end
  end
end
