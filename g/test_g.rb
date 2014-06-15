require "minitest/autorun"
require_relative "g"

describe "SushiContest" do
  it "must determine the winner (Case #1)" do
    contest = SushiContest.new(5, 0b01010)

    contest.winner.must_equal("Betka")
  end

  it "must determine the winner (Case #2)" do
    contest = SushiContest.new(6, 0b110101)
    
    contest.winner.must_equal("Adam")
  end

  it "must transition states after eating" do
    contest = SushiContest.new(5, 0b01010)
    contest.eat(3)

    contest.state.must_equal(0b00100)
  end
end
