require_relative 'spec_helper'
require 'question'

describe Question do

  let(:raw) { "29 22 Last name of the next President of the United States after Dwight D. Eisenhower" }

  def question(line = raw, direction = :sideways)
    Question.new(line: line, direction: direction)
  end

  it 'has coordinates' do
    question.x.must_equal(29)
    question.y.must_equal(22)
  end

  it 'has a direction do' do
    question.direction.must_equal(:sideways)
  end

  it 'holds the question text' do
    question.text.must_equal(["Last", "name", "of", "the", "next", "President", "of", "the", "United", "States", "after", "Dwight", "D.", "Eisenhower"])
  end

  it 'can be assigned an answer' do
    q = question
    q.solution = "Yep"
    q.solution.must_equal("Yep")
    q.size.must_equal(3)
  end

end
