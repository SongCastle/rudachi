require_relative 'test_helper'

describe Rudachi::VERSION do
  it 'current Rudachi version' do
    expect(Rudachi::VERSION).must_equal('1.1.1')
  end
end
