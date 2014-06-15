require "pstore"

DIGITS = (1..9).to_a

orders = DIGITS.permutation(DIGITS.length).to_a.map(&:join)
orders.sort

File.unlink("indexes.pstore")
indexes = PStore.new("indexes.pstore")
indexes.transaction do
  orders.each do |order|
    indexes[order] = nil
  end
end
