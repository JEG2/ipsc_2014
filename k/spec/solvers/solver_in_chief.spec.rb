require_relative '../spec_helper'
require 'solvers/solver_in_chief'

describe SolverInChief do

  def solver
    SolverInChief.new
  end

  it 'knows if a question is solvable' do
    wrong = OpenStruct.new(text: %w[ you wouldnt solve this])
    possible = OpenStruct.new(text: %w[ First name of the President of the United States who held the office in 2011 ])
    solver.solvable?(wrong).must_equal(false)
    solver.solvable?(possible).must_equal(true)
  end

  it 'can solve a first name question' do
    first_name = OpenStruct.new(text: %w[ First name of the President of the United States who held the office in 2011 ])
    solver.answer(first_name).must_equal("barack")
  end

  it 'can solve a last name question' do
    last_name = OpenStruct.new(text: %w[ Last name of the President of the United States who held the office in 1987 ])
    solver.answer(last_name).must_equal("reagan")
  end

  it 'can solve a president after question' do
    after = OpenStruct.new(text: %w[ Last name of the next President of the United States after Warren G. Harding ])
    solver.answer(after).must_equal('coolidge')
  end

  it 'can solve a president before question' do
    before = OpenStruct.new(text: %w[ Last name of the next President of the United States before Gerald Ford ])
    solver.answer(before).must_equal('nixon')
  end

end
