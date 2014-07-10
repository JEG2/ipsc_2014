require_relative 'spec_helper'
require 'super_solver'

describe SuperSolver do

  def test_solver
    Class.new do
      def initialize(solvable, answer = nil)
        @answer   = answer
        @solvable = solvable
      end

      def solvable?(question)
        @solvable
      end

      def answer(question)
        @answer
      end
    end
  end

  it 'can assign an answer' do
    solver1 = test_solver.new(true, 'GREAT SUCCESS')
    solvers = [ solver1 ]
    question = OpenStruct.new(text: ["some", "question"])

    ss = SuperSolver.new(solvers)
    ss.solve(question)
    question.solution.must_equal('GREAT SUCCESS')
  end

  it 'can pick a solver' do
    solvers = [
      test_solver.new(false),
      test_solver.new(false),
      test_solver.new(true, 'yep'),
      test_solver.new(false) ]
    question = OpenStruct.new(text: ["some", "question"])

    ss = SuperSolver.new(solvers)
    ss.solve(question)
    question.solution.must_equal('yep')
  end

  it 'raises an error when a solver isn\'t found' do
    solvers = [
      test_solver.new(false),
      test_solver.new(false)
    ]

    question = OpenStruct.new(text: ["some", "question"])
    ss = SuperSolver.new(solvers)
    lambda { ss.solve(question) }.must_raise NotSolveable
  end
end
