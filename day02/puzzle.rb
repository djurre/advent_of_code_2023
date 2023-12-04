input = File.readlines('day02/input.txt', chomp: true)

# part 1
results = {}
input.map do |line|
  game_number = line.scan(/\d+/).first.to_i
  sets = line.scan(/(\d+) (red|green|blue)/)
  sets.each do |set|
    results[game_number] ||= {}
    results[game_number][set[1]] = set[0] ? [set[0].to_i, results[game_number][set[1]].to_i].max : set[0]
  end
end

answer = results.map do |game_number, max_counts|
  next if max_counts['red'] > 12 || max_counts['green'] > 13 || max_counts['blue'] > 14
  game_number
end.compact.sum

pp answer

# part 2
answer = results.map do |game_number, max_counts|
  max_counts['red'] * max_counts['green'] * max_counts['blue']
end.sum

pp answer
