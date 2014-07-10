class ChemSolver

  attr_reader :data

  def initialize
    @data = load_file.split(/\n/)
  end

  def solvable?(question)
    question.text.include?("Chemical") && question.text.include?("element")
  end

  def answer(question)
    if question.text.include?('symbol')
      solve_symbol(question.text)
    elsif question.text.include?('number')
      solve_number(question.text)
    else
     fail "Unknown Chemical question: #{question.text.join(" ")}"
    end
  end

  private

  def solve_symbol(question)
    data.select { |line|
      line.split(/\s/)[2] == question.last }.first.split(/\s/).last.downcase
  end

  def solve_number(question)
    data.select { |line|
      line.split(/\s/).first.to_i == eval(question.last) }.first.split(/\s/).last.downcase
  end

  def load_file
    File.read(File.path( __dir__ + '/../../data/elements.txt'))
  end
end
