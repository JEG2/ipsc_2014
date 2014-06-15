require 'ray'
require_relative "sushi_contest"


contest = SushiContest.new(ARGV[0].dup)

Ray.game "Test", :size => [50*contest.size, 100] do
  register { add_hook :quit, method(:exit!) }

  scene :square do
    rects = contest.state.chars.map.with_index do |e,i|
      poly = Ray::Polygon.rectangle([0, 0, 50, 50], e == "1" ? Ray::Color.red : Ray::Color.black)
      poly.pos = [50*i, 0]
      poly.outlined = true
      poly.outline = Ray::Color.white

      poly
    end

    on :mouse_release do |_, pos|
      index = pos.x.to_i / 50

      contest.eat(index)

      rects.each.with_index do |e,i|
        if contest.state[i] == "1"
          e.color = Ray::Color.red
        else
          e.color = Ray::Color.black
        end
      end
    end

    render do |win|
      rects.each { |r| win.draw(r) }

      @text = text "Player: #{contest.current_player} ----- " +
                   "Winner: #{contest.winner}",
                :at => [10, 60], :size => 16
      win.draw(@text)
    end
  end

  scenes << :square
end
