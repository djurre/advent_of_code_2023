input = File.readlines('day09/input.txt', chomp: true)

histories = input.map { |line| line.split(' ').map(&:to_i) }

def find(history)
  return 0 if history.uniq == [0]

  differences = (history.size - 1).times.map { |index| history[index + 1] - history[index] }
  history.last + find(differences)
end

# part 1
answer = histories.map { |history| find(history) }
pp answer.sum

# part 2
answer = histories.map(&:reverse).map { |history| find(history) }
pp answer.sum
