input = File.readlines('day04/input.txt', chomp: true)

copies = [1] * input.count

input.each_with_index do |line, index|
  winning, mine = line.split(":")[1].split("|").map(&:split)
  matching = winning & mine
  next if matching.empty?

  (index + 1..index + matching.count).each do |copies_index|
    copies[copies_index] += copies[index]
  end
end

pp copies.sum
