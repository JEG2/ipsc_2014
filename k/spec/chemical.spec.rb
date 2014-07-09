require_relative 'spec_helper'
require_relative '../lib/chemical'

describe Chemical do

  let(:number) { %w[Chemical element with atomic number 102] }
  let(:expression) { %w[Chemical element with atomic number (((2106/39)-(75-39))*((96-27)/(161/7)))]}
  let(:symbol) { %w[Chemical element with the symbol Pa] }
  def chemical(words)
    Chemical.new(words)
  end

  it 'finds the name of the chemical element by number' do
    chemical(number).name.must_equal('nobelium')
  end

  it 'finds the name of the chemical element by expression' do
    chemical(expression).name.must_equal('xenon')
  end

  it 'finds the name by symbol' do
    chemical(symbol).name.must_equal('protactinium')
  end

end
