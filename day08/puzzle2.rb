input = File.read('day08/input.txt', chomp: true).split("\n\n")

map = {}
instructions = input[0].chars
input[1].split("\n").map { |line| line.scan(/(\w+)/).flatten }.each do |line|
  map[line[0]] = { "L" => line[1], "R" => line[2] }
end

starting_nodes = map.keys.select { |key| key.chars.last == "A" }
step_counts = []

starting_nodes.each do |current_node|
  step_count = 0

  while current_node.chars.last != "Z"
    instruction = instructions[step_count % instructions.length]
    current_node = map[current_node][instruction]
    step_count += 1
  end

  step_counts << step_count
end

pp step_counts.reduce(1, :lcm)
