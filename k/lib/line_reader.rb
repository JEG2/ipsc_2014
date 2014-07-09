class LineReader

  attr_reader :line

  def initialize(line)
    @line = line
  end

  def coords
    split[0..1].map(&:to_i)
  end

  def subject
    split[2..-1]
  end

  private

  def split
    @split = line.split(/\s/)
  end
end
