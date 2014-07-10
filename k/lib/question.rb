class Question

  attr_accessor :solution
  attr_reader :direction, :text, :line, :coords

  def initialize(line:, direction:)
    @direction = direction
    @line      = line.split(/\s/)
    @coords    = parse_coords
    @text      = parse_text
  end

  def x
    @x ||= coords.first.to_i
  end

  def y
    @y ||= coords.last.to_i
  end

  def size
    solution.size
  end

  private

  def parse_coords
    line[0..1]
  end

  def parse_text
    line[2..-1]
  end
end
