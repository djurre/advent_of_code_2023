input = File.readlines('day04/input.txt', chomp: true)

result = input.map do |line|
  winning, mine = line.split(":")[1].split("|").map(&:split)
  matching = winning & mine
  next if matching.empty?

  2**(matching.count - 1)
end

pp result.compact.sum
