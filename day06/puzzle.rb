input = File.readlines('day06/input.txt', chomp: true)

def get_answer(races)
  answer = races.map do |race|
    results = []
    race[0].times do |second|
      speed = second
      time_to_move = race[0] - second
      results[second] = speed * time_to_move
    end
    results.select { |result| result > race[1] }
  end

  pp answer.map(&:count).inject(:*)
end

# part 1
times = input[0].scan(/(\d+)/).flatten.map(&:to_i)
distances = input[1].scan(/(\d+)/).flatten.map(&:to_i)
races = times.zip(distances)
get_answer(races)

# part 2
time = input[0].scan(/(\d+)/).flatten.join.to_i
distance = input[1].scan(/(\d+)/).flatten.join.to_i
get_answer([[time, distance]])
