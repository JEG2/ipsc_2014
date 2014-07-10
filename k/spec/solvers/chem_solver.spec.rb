require_relative '../spec_helper'
require 'solvers/chem_solver'

describe ChemSolver do

  def solver
    ChemSolver.new
  end

  it 'knows if a question is solvable' do
    wrong = OpenStruct.new(text: %w[Some silly question you cant solve])
    possible = OpenStruct.new(text: %w[Chemical element with atomic number 34])
    solver.solvable?(wrong).must_equal(false)
    solver.solvable?(possible).must_equal(true)
  end

  it 'can find the answer to symbol questions' do
    number = OpenStruct.new(text: %w[Chemical element with atomic number 34])
    solver.answer(number).must_equal("selenium")
  end

  it 'can find the answer to symbol questions' do
    symbol = OpenStruct.new(text: %w[Chemical element with the symbol Au])
    solver.answer(symbol).must_equal("gold")
  end

  it 'raises an error when it cannot find an answer' do
    unpossible = OpenStruct.new(text: %w[Chemical element with the lol nope])
    lambda { solver.answer(unpossible)}.must_raise RuntimeError
  end
end
