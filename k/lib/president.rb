class President

  attr_reader :years, :name

  def initialize(data)
    @years = build_range(data.split(/\s/).last)
    @name  = data.split(/\s/)[0..-2]
  end

  def in_office?(year)
    year.to_i.between?(years.first, years.last)
  end

  def first_name
    name.first.downcase
  end

  def last_name
    name.last.downcase
  end

  private

  def build_range(range)
    range.split(/-/).map { |element| element.gsub(/[\D]/, '').to_i }
  end
end
