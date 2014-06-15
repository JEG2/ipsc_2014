def solve(correct, typed)
  retyped = "*#{correct}*"

  first_incorrect = (0..correct.length).find { |i| correct[i] != typed[i] }
  corrected       =
    if first_incorrect
      "<" * typed[first_incorrect..-1].length + correct[first_incorrect..-1]
    elsif typed.length > correct.length
      "<" * (typed.length - correct.length)
    elsif correct == typed
      ""
    else
      fail "unexpected scenario"
    end
  corrected << "*"

  corrected.size < retyped.size ? corrected : retyped
end

cases = ARGF.gets.to_i

cases.times do
  gets

  correct = gets.strip
  typed   = gets.strip
  puts "Correct:  #{correct}" if $DEBUG
  puts "  Typed:  #{typed}"   if $DEBUG
  puts solve(correct, typed)
end
