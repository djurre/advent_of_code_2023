input = File.readlines('day03/input.txt', chomp: true)

@grid = Hash.new('.')
input.each_with_index do |line, index_y|
  line.chars.each_with_index { |char, index_x| @grid[[index_x, index_y]] = char }
end

@machine_numbers = []

def check_neighbours(line_number, start, finish, number)
  neigbours = []

  # check left side
  neigbours << @grid[[start - 1, line_number - 1]]
  neigbours << @grid[[start - 1, line_number]]
  neigbours << @grid[[start - 1, line_number + 1]]


  # check right side
  neigbours << @grid[[finish + 1, line_number - 1]]
  neigbours << @grid[[finish + 1, line_number]]
  neigbours << @grid[[finish + 1, line_number + 1]]

  # check top and bottom
  (start..finish).each do |index|
    neigbours << @grid[[index, line_number - 1]]
    neigbours << @grid[[index, line_number + 1]]
  end

  if neigbours.uniq.size > 1 || neigbours.uniq.first != '.'
    @machine_numbers << number
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

pp @machine_numbers.map(&:to_i).sum
