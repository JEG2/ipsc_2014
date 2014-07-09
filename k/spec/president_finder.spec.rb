require_relative 'spec_helper'
require_relative '../lib/president'

class PresidentFinder

  attr_reader :presidents

  def initialize(presidents)
    @presidents = presidents
  end

  def find(data)
    if data.include?('First')
      find_president(data).first_name
    elsif data.include?('Last')
      find_president(data).last_name
    else
      fail 'We have a problem'
    end
  end

  private

  def find_president(data)
    if data.last =~ /\d+/
      presidents.select { |president| president.in_office?(data.last.to_i) }.first
    elsif data.include?('after')
      index = presidents.find_index { |president|
        president.name { |n| data.join(' ').split('after').last.strip.include?(n) }.all?
      }
      presidents[(index + 1)]
    elsif data.include?('before')
      index = presidents.find_index { |president|
        president.name.join(' ') == data.join(' ').split('before').last.strip }
      presidents[(index - 1)]
    else
      fail 'we have a a problem'
    end
  end

end

describe PresidentFinder do

  let(:presidents) {
    file = File.read(File.path(__dir__ + '/../presidents_of_the_usa.txt'))
    lines = file.split(/\n/)
    lines.map { |line| President.new(line) }
  }
  let(:first_name_by_year) { %w[First name of the President of the United States who held the office in 1913]}
  let(:last_name_by_year) { %w[Last name of the President of the United States who held the office in 1922 ]}
  let(:by_name_before) { %w[First name of the previous President of the United States before John Tyler]}
  let(:by_name_after) { %w[Last name of the next President of the United States after Gerald Ford]}

  def finder(presidents)
    PresidentFinder.new(presidents)
  end

  it 'can find the wanted name of the president given a year' do
    finder(presidents).find(last_name_by_year).must_equal('harding')
    finder(presidents).find(first_name_by_year).must_equal('william')
  end

  it 'can find the president before when given a name' do
    finder(presidents).find(by_name_before).must_equal('william')
  end

  it 'can find the president after when given a name' do
    finder(presidents).find(by_name_after).must_equal('carter')
  end

end
