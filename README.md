# rudachi
[Sudachi](https://github.com/WorksApplications/Sudachi) wrapper Gem for JRuby.

- Text base
```rb
Rudachi::TextParser.parse('東京都へ行く')
=> "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都\nへ\t助詞,格助詞,*,*,*,*\tへ\n行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く\nEOS\n"
```

- File base
```rb
File.open('sample.txt', 'w') { |f| f << '東京都へ行く' }
Rudachi::FileParser.parse('sample.txt')
=> "東京都\t名詞,固有名詞,地名,一般,*,*\t東京都\nへ\t助詞,格助詞,*,*,*,*\tへ\n行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く\nEOS\n"
```

- With some options
```rb
Rudachi::TextParser.new(o: 'result.txt', m: 'A').parse('東京都へ行く')
File.read('result.txt')
=> "東京\t名詞,固有名詞,地名,一般,*,*\t東京\n都\t名詞,普通名詞,一般,*,*,*\t都\nへ\t助詞,格助詞,*,*,*,*\tへ\n行く\t動詞,非自立可能,*,*,五段-カ行,終止形-一般\t行く\nEOS\n"
```

## Requirements

- [JRuby](https://github.com/jruby/jruby) 9.1.3.0 or later
- [Sudachi](https://github.com/WorksApplications/Sudachi)

## Installation

1. Install JAR and dictionary of Sudachi ([details](https://github.com/WorksApplications/Sudachi/blob/develop/docs/tutorial.md#linux-%E3%81%AE%E5%A0%B4%E5%90%88))

- Install the Sudachi JAR file
```sh
$ wget https://github.com/WorksApplications/Sudachi/releases/download/v0.5.3/sudachi-0.5.3-executable.zip
$ unzip sudachi-0.5.3-executable.zip
$ ls sudachi-0.5.3
LICENSE-2.0.txt  README.md  javax.json-1.1.jar	jdartsclone-1.2.0.jar  licenses  sudachi-0.5.3.jar  sudachi.json  sudachi_fulldict.json
```

- Install the Sudachi dictionary
```sh
$ wget http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict/sudachi-dictionary-latest-full.zip
$ unzip -j -d sudachi-dictionary-latest-full sudachi-dictionary-latest-full.zip
$ mv sudachi-dictionary-latest-full/system_full.dic sudachi-dictionary-latest-full/system_core.dic
$ ls sudachi-dictionary-latest-full
LEGAL  LICENSE-2.0.txt	system_core.dic
```

2. Install Rudachi

```rb
# Gemfile
gem 'rudachi', git: 'https://github.com/SongCastle/rudachi.git', tag: 'v1.0.0'
```

Then run `bundle install` .

3. Initialize Rudachi

```rb
Rudachi.configure do |config|
  config.jar_path = 'sudachi-0.5.3/sudachi-0.5.3.jar'
end

Rudachi::Option.configure do |config|
  config.p = 'sudachi-dictionary-latest-full'
end
```

4. Dit it !!

```rb
require 'rudachi'

Rudachi::TextParser.parse('こんにちは世界')
=> "こんにちは\t感動詞,一般,*,*,*,*\t今日は\n世界\t名詞,普通名詞,一般,*,*,*\t世界\nEOS\n"
```
