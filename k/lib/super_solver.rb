class SuperSolver

  attr_reader :solvers

  def initialize(solvers)
    @solvers = solvers
  end

  def solve(question)
    question.solution = find_answer(question)
  end

  private

  def find_answer(question)
    solvers.detect { |solver| solver.solvable?(question) }.answer(question)

    rescue NoMethodError => ex
      if ex.message == "undefined method `answer' for nil:NilClass"
        raise NotSolveable.new(question)
      end
  end

end

class NotSolveable < StandardError
  def initialize(question)
    @question = question
    super message
  end

  def message
    "Could not solve: #{@question.text.join(" ")}"
  end
end
