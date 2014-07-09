class Subject
  attr_reader :words

  TOPICS = { 'President' => :president, 'Pokemon' => :pokemon, 'Chemical' => :chemical }

  def initialize(words)
    @words = words
  end

  def topic
    TOPICS.each do |topic, value|
      return value if words.include?(topic)
    end
  end
end
