class SolverInChief

  attr_reader :presidents

  def initialize
    @presidents = load_file.split(/\n/).each_with_index.map { |line, index| President.new(line,index) }
  end

  def solvable?(question)
    question.text.include?("President") &&
      question.text.include?("United")  &&
      question.text.include?("States")
  end

  def answer(question)
    text = question.text
    if text.include?('First') && text.include?('name')
      find_president(text).first_name
    elsif text.include?('Last') && text.include?('name')
      find_president(text).last_name
    else
      fail "Unknown Presidential Question: #{question.text.join(" ")}"
    end
  end

  private

  def find_president(text)
    if text.last =~/\d+/
      presidents.detect { |president| president.in_office?(text.last.to_i) }
    elsif text.include?('after')
      president = presidents.detect { |president| president.compare_name(text[11..-1]) }
      fail "Could not find name #{text[11..-1]}"unless president
      presidents[president.number + 1]
    elsif text.include?('before')
      president = presidents.detect { |president| president.compare_name(text[11..-1]) }
      fail "Could not find name #{text[11..-1]}"unless president
      presidents[president.number - 1]
    else
      fail "Unknown Presidential Question: #{text.join(" ")}"
    end
  end

  def load_file
    File.read(File.path( __dir__ + '/../../data/presidents_of_the_usa.txt'))
  end

end

class President

  attr_reader :years, :name, :number

  def initialize(data,number)
    @years = build_range(data.split(/\s/).last)
    @name  = data.split(/\s/)[0..-2]
    @number = number
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

  def compare_name(text)
    if text.size != name.size
      text.first == name.first && text.last == name.last
    elsif text.size == 3 && name.size == 3 && text[1].size != name[1].size
      text.first  == name.first &&
        text.last == name.last &&
        text[1].start_with?(name[1][0])
    else
      text == name
    end
  end

  private

  def build_range(range)
    range.split(/-/).map { |element| element.gsub(/[\D]/, '').to_i }
  end

end
