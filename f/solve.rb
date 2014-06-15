require "pstore"

def find_solution(usable, rows, board = [ ])
  unless board.empty?
    starts = board.map { |row| row[0] }.join
    rows   = rows.select { |row| row =~ /\A[^#{starts}]/ }
  end
  loop do
    row       = rows.sample
    new_board = board + [row]
    if new_board.size == 9
      if valid_solution?(new_board)
        new_board.each do |new_row|
          puts "#{new_row} #{usable[new_row]}"
        end
        exit
      end
    else
      find_solution(usable, rows - [row], new_board)
    end
  end
end

def valid_solution?(board)
  (0..8).each do |i|
    column = board.map { |row| row[i] }.sort.join
    return false unless column == "123456789"
  end
  (0..3).each do |x|
    (0..3).each do |y|
      box = board[y * 3, 3].flat_map { |row| row[x * 3, 3].chars }.sort.join
      return false unless box == "123456789"
    end
  end
  true
end

usable  = { }
indexes = PStore.new("indexes.pstore")
indexes.transaction(true) do
  indexes.roots.each do |sequence|
    i = indexes[sequence]
    if i
      usable[sequence] = i
    end
  end
end

rows = usable.keys.sort
find_solution(usable, rows)
