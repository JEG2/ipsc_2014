require_relative 'spec_helper'
require_relative '../lib/president'

describe President do
  let(:string) {"Andrew Jackson (1829-1837)"}

  def president(string)
    President.new(string)
  end

  it 'knows when it was in office' do
    president(string).in_office?(1830).must_equal(true)
  end

  it 'has a name' do
    president(string).first_name.must_equal('andrew')
    president(string).last_name.must_equal('jackson')
  end

end
