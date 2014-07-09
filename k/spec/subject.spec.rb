require_relative 'spec_helper'
require_relative '../lib/subject'

describe Subject do

  let(:pokemon) { %w[ Pokemon which evolves from Growlithe ] }
  let(:president) { %w[ Last name of the President of the United States who held the office in 1858 ] }
  let(:chemical) { %w[ Chemical element with the symbol Ne ] }

  def subject(array)
    Subject.new(array)
  end

  it 'can determine if pokemon' do
    subject(pokemon).topic.must_equal(:pokemon)
  end

  it 'can determine if president' do
    subject(president).topic.must_equal(:president)
  end

  it 'can determine if chem' do
    subject(chemical).topic.must_equal(:chemical)
  end

end
