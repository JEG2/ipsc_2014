class Board

  attr_accessor :puzzle
  attr_reader :lines, :rows, :columns

  def initialize(raw)
    @lines    = raw.split(/\n/)
    size     = lines.first.split(/\s/)
    @rows    = size.first.to_i
    @columns = size.last.to_i
    @puzzle  = parse_out_the_puzzle
  end

  def show
    @puzzle.map { |line| line.join('') }.join("\n")
  end

  def insert(question)
    begin
      if question.direction == :down
        sideways = puzzle.transpose
        line = sideways[question.y].join
        line[(question.x)...(question.x + question.size)] = question.solution
        sideways[question.y] = line.split(//)
        @puzzle = sideways.transpose
      else
        line = puzzle[question.x].join
        line[(question.y)...(question.y + question.size)] = question.solution
        @puzzle[question.x] = line.split(//)
      end
    rescue
      puts "ERROR"
      puts question.text.join(" ")
      puts show
      raise
    end
  end

  def valid?
    puzzle.size == rows && puzzle.transpose.size == columns
  end

  def sideways_question_count
    lines[rows + 1].to_i
  end

  def sideways_questions
    start_index = rows + 1
    lines[(start_index + 1)..(start_index + sideways_question_count)]
  end

  def down_questions
    start_index = rows + 1 + sideways_question_count + 1
    lines[(start_index + 1)..-1]
  end

  def down_question_count
    lines[rows + 1 + sideways_question_count + 1].to_i
  end

  private

  def parse_out_the_puzzle
    lines[1..rows].map { |line| line.split(//) }
  end

end
