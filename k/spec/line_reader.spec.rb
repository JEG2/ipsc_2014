require_relative 'spec_helper'
require_relative '../lib/line_reader'

describe LineReader do

  let(:pokemon) {"0 18 Pokemon which evolves from Oddish"}

  def reader(line)
    LineReader.new(line)
  end

  it 'can parse the line coords' do
    reader(pokemon).coords.must_equal([0,18])
  end

  it 'can parse out the subject' do
    reader(pokemon).subject.must_equal(%w[ Pokemon which evolves from Oddish ])
  end
end
