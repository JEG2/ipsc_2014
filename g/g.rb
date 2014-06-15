class SushiContest
  def initialize(tray_count, state)
    @state = state
  end

  attr_reader :state

  def winner
    "Not done yet!" unless @state.zero?
  end

  def eat(index)
    
  end
end
