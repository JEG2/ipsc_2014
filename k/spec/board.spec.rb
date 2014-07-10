require_relative 'spec_helper'

require 'board'

describe Board do
  let(:data) { File.read(__dir__ + '/../data/k1.in') }
  let(:example) { "3 4\n..#.\n####\n..#." }

  def board(input = data)
    Board.new(input)
  end

  it 'can read the board out of a complete file' do
    board.rows.must_equal(30)
    board.columns.must_equal(30)
    board.puzzle.size.must_equal(30)
    board.puzzle.first.size.must_equal(30)
  end

  it 'knows if it is valid' do
    board.valid?.must_equal(true)
  end

  it 'can export a board' do
    board(example).show.must_equal("..#.\n####\n..#.")
  end

  it 'can insert a horizontal answer' do
    question = OpenStruct.new(x: 1, y: 0, direction: :sideways, solution: 'ipsc', size: 4)
    test_board = board(example)
    test_board.insert(question)
    test_board.show.must_equal("..#.\nipsc\n..#.")
    test_board.valid?.must_equal(true)
  end

  it 'can insert a vertical answer' do
    question = OpenStruct.new(x: 0, y: 2, direction: :down, solution: 'tsp', size: 3)
    test_board = board(example)
    test_board.insert(question)
    test_board.show.must_equal(<<RESULT.chomp)
..t.
##s#
..p.
RESULT
    test_board.valid?.must_equal(true)
  end

  it 'can parse out the question counts' do
    test_board = board
    test_board.sideways_question_count.must_equal(35)
    test_board.down_question_count.must_equal(35)
  end

  it 'can parse out the sideways questions' do
    test_board = board
    first = "0 18 Pokemon which evolves from Oddish"
    last  = "29 22 Last name of the next President of the United States after Dwight D. Eisenhower"
    test_board.sideways_questions.size.must_equal(test_board.sideways_question_count)
    test_board.sideways_questions.first.must_equal(first)
    test_board.sideways_questions.last.must_equal(last)
  end

  it 'can parse out the down questions' do
    test_board = board
    first = "0 8 First name of the President of the United States who held the office in 2011"
    last  = "24 28 Pokemon with number #98"
    test_board.down_questions.size.must_equal(test_board.sideways_question_count)
    test_board.down_questions.first.must_equal(first)
    test_board.down_questions.last.must_equal(last)
  end
end
