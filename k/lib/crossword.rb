require_relative 'board'
require_relative 'question'
require_relative 'super_solver'

# solvers
require_relative 'solvers/chem_solver'
require_relative 'solvers/solver_in_chief'

module Crossword

  def self.solve(input)
    board     = Board.new(input)
    questions = build_questions(board)
    solvers   = load_solvers
    ss        = SuperSolver.new(solvers)

    questions.each { |question|
      begin
        ss.solve(question)
      rescue NotSolveable => ex
        puts ex.message
      end
    }

    questions.each { |question| board.insert(question) if question.solution }

    puts "INVALID BOARD STATE" if !board.valid?
    puts board.show
  end

  def self.load_solvers
    [ ChemSolver.new, SolverInChief.new ]
  end

  def self.build_questions(board)
    sideways = board.sideways_questions.map { |line| Question.new(line: line, direction: :sideways) }
    down     = board.down_questions.map     { |line| Question.new(line: line, direction: :down) }
    sideways + down
  end
end
