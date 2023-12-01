input = File.readlines('day01/input.txt', chomp: true)

# puzzle 1
pp input.map { |line| line.scan(/\d/) }.map { |num| "#{num.first}#{num.last}" }.map(&:to_i).sum

# puzzle 2
lines = input.map do |line|
  line.gsub(/one/, 'one1one')
      .gsub(/two/, 'two2two')
      .gsub(/three/, 'three3three')
      .gsub(/four/, 'four4four')
      .gsub(/five/, 'five5five')
      .gsub(/six/, 'six6six')
      .gsub(/seven/, 'seven7seven')
      .gsub(/eight/, 'eight8eight')
      .gsub(/nine/, 'nine9nine')
end

pp lines.map { |line| line.scan(/\d/) }.map { |num| "#{num.first}#{num.last}" }.map(&:to_i).sum
