input = File.readlines('day03/input.txt', chomp: true)

@grid = Hash.new('.')
input.each_with_index do |line, index_y|
  line.chars.each_with_index { |char, index_x| @grid[[index_x, index_y]] = char }
end

@machine_numbers = []

def check_gear(coord, number)
  if @grid[coord] == '*'
    @machine_numbers << { number: number.to_i, coord: coord }
  end
end

def check_neighbours(line_number, start, finish, number)
  # check left side
  check_gear([start - 1, line_number - 1], number)
  check_gear([start - 1, line_number], number)
  check_gear([start - 1, line_number + 1], number)

  # check right side
  check_gear([finish + 1, line_number - 1], number)
  check_gear([finish + 1, line_number], number)
  check_gear([finish + 1, line_number + 1], number)

  # check top and bottom
  (start..finish).each do |index|
    check_gear([index, line_number - 1], number)
    check_gear([index, line_number + 1], number)
  end

end

input.each_with_index do |line, index_y|
  numbers_on_line = line.scan(/\d+/)
  numbers_on_line.uniq.each do |number|
    ".#{line}.".enum_for(:scan, /\D(?=#{number}\D)/).each do
      index = Regexp.last_match.offset(0).first
      check_neighbours(index_y, index, index + number.length - 1, number)
    end

  end
end

answer = @machine_numbers.group_by { |gears| gears[:coord] }.reject { |_, v| v.size != 2 }
answer.transform_values! { |v| v.map { |gear| gear[:number] } }
pp answer.values.map { |v| v.inject(&:*) }.sum
