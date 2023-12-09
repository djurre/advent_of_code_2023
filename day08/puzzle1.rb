input = File.read('day08/input.txt', chomp: true).split("\n\n")

map = {}
instructions = input[0].chars
input[1].split("\n").map { |line| line.scan(/(\w+)/).flatten }.each do |line|
  map[line[0]] = { "L" => line[1], "R" => line[2] }
end

current_node = "AAA"
step_count = 0

while current_node != "ZZZ"
  instruction = instructions[step_count % instructions.length]
  current_node = map[current_node][instruction]
  step_count += 1
end

pp step_count
