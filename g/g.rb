class SushiContest
  def initialize(tray_count, state)
    @state = state
    @players = ["Adam", "Betka"].cycle
    
    @players.next
  end

  attr_reader :state

  def winner
    return "Nobody" if @state[/1/]

    @players.peek
  end

  def eat(index)
    raise unless @state[index] == "1"

    @state[index] = "0"
    @state.slice!(0)
    @state << "0"

    @players.next
  end
end
