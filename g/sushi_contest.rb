class SushiContest
  def initialize(state)
    @state = state
    @players = ["Adam", "Betka"].cycle
    
    @current_player = @players.next
  end

  attr_reader :state, :current_player

  def size
    @state.size
  end

  def winner
    return "Nobody" if @state[/1/]

    @players.peek
  end

  def eat(index)
    raise unless @state[index] == "1"

    @state[index] = "0"
    @state.slice!(0)
    @state << "0"

    @current_player = @players.next
  end
end
