require "minitest/autorun"
require_relative "sushi_contest"

describe "SushiContest" do
  it "must determine the winner (Case #1)" do
    contest = SushiContest.new("01010")

    contest.eat(1)
    contest.eat(2)

    contest.winner.must_equal("Betka")
  end

  it "must determine the winner (Case #2)" do
    contest = SushiContest.new("110101")

    contest.eat(1)
    contest.eat(2)
    contest.eat(3)  
    
    contest.winner.must_equal("Adam")
  end

  it "must transition states after eating" do
    contest = SushiContest.new("01010")
    contest.eat(1)

    contest.state.must_equal("00100")
  end
end
