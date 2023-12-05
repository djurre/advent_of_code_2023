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

seeds = input[0].scan(/(\d+)/).flatten.map(&:to_i).each_slice(2).map { |pair| [(pair[0]..(pair[0] + pair[1] - 1))] }

maps = (1..7).map { |index| create_map(input[index]) }

answer = seeds.map do |num_ranges|
  maps.each do |map|
    new_num_ranges = []
    min_all_ranges = map.map { |x| x[:source_range] }.map(&:min).min
    max_all_ranges = map.map { |x| x[:source_range] }.map(&:max).max

    num_ranges.each do |num_range|
      # these fall outside of all ranges so we keep the original range
      new_num_ranges << num_range if num_range.min < min_all_ranges || num_range.max > max_all_ranges

      # create a new destination range for each range that falls within the map
      map.each do |map_item|
        source_range = map_item[:source_range]
        source_range_min = [num_range.min, source_range.min].max
        source_range_max = [num_range.max, source_range.max].min
        next if source_range_min > source_range_max

        new_num_ranges << (map_item[:destination] + (source_range_min - source_range.min)..map_item[:destination] + (source_range_max - source_range.min))
      end
    end
    num_ranges = new_num_ranges
  end
  num_ranges
end

pp answer.flatten.map(&:min).min
