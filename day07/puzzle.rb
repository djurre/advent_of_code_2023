input = File.readlines('day07/input.txt', chomp: true)

class Hand
  TYPES = {
    0 => 'High Card',
    1 => 'Pair',
    2 => 'Two Pairs',
    3 => 'Three of a Kind',
    4 => 'Full House',
    5 => 'Four of a Kind',
    6 => 'Five of a Kind',
  }.freeze

  attr_accessor :hand_type, :cards, :bid, :order

  def initialize(hand_type, hand, bid, order)
    self.hand_type = hand_type
    self.cards = hand.chars
    self.bid = bid.to_i
    self.order = order
  end

  def to_s
    "#{cards.join} - #{bid} - #{TYPES[hand_type]}"
  end

  def <=>(other)
    first_different_pair = cards.zip(other.cards).map(&:uniq).reject { |cards| cards.count == 1 }.first
    if hand_type == other.hand_type
      order.index(first_different_pair[0]) <=> order.index(first_different_pair[1])
    else
      hand_type <=> other.hand_type
    end
  end
end

def get_hand_type(hand)
  cards = hand.chars
  unique_cards = cards.group_by { |x| x[0] }.values
  case unique_cards.count
  when 5
    0
  when 4
    1
  when 3
    unique_cards.map(&:count).flatten.include?(2) ? 2 : 3
  when 2
    unique_cards.map(&:count).flatten.include?(3) ? 4 : 5
  when 1
    6
  else
    raise 'Invalid hand'
  end
end

# part 1
@order = %w(2 3 4 5 6 7 8 9 T J Q K A).freeze
all_hands = input.map do |line|
  hand, bid = line.split(' ')
  hand_type = get_hand_type(hand)
  Hand.new(hand_type, hand, bid, @order)
end

pp all_hands.sort.map.with_index { |hand, index| (index + 1) * hand.bid }.sum

# part 2
@order = %w(J 2 3 4 5 6 7 8 9 T Q K A).freeze

def get_best_joker_hand(hand)
  @order.map do |joker_option|
    new_hand = hand.gsub('J', joker_option)
    Hand.new(get_hand_type(new_hand), new_hand, 0, @order)
  end.sort.last
end

all_hands = input.map do |line|
  hand, bid = line.split(' ')
  hand_type = get_hand_type(hand)
  if hand.include?('J')
    joker_hand_type = get_best_joker_hand(hand).hand_type
    Hand.new(joker_hand_type, hand, bid, @order)
  else
    Hand.new(hand_type, hand, bid, @order)
  end
end

pp all_hands.sort.map.with_index { |hand, index| (index + 1) * hand.bid }.sum
