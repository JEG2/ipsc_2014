class Chemical

  attr_reader :words, :elements

  def initialize(words)
    @words = words
    @elements = open_file.split(/\n/)
  end

  def name
    get_name_from(type)
  end

  private

  def type
    return :symbol if words.include?('symbol')
    return :number if words.include?('number')
  end

  def get_name_from(type)
    if type == :symbol
      elements.select { |element|
        element.split(/\s/)[2] == words.last }.first.split(/\s/).last.downcase
    else
      elements.select { |element|
        element.split(/\s/).first.to_i == eval(words.last) }.first.split(/\s/).last.downcase
    end
  end

  def open_file
    File.read(File.path( __dir__ + '/../elements.txt'))
  end
end
