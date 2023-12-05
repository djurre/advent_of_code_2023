input = File.read('day05/input.txt', chomp: true).split("\n\n")

def create_map(type)
  type.split("\n").drop(1).map do |map|
    destination, start, width = map.scan(/(\d+)/).flatten.map(&:to_i)
    {
      source_range: start..(start + width - 1),
      destination: destination
    }
  end
end

seeds = input[0].scan(/(\d+)/).flatten.map(&:to_i)
maps = (1..7).map { |index| create_map(input[index]) }

answer = seeds.map do |num|
  maps.each do |map|
    range_to_use = map.detect { |map_item| map_item[:source_range].include?(num) }
    num = range_to_use[:destination] + (num - range_to_use[:source_range].first) if range_to_use
  end
  num
end

pp answer.min
