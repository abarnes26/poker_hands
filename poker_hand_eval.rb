# Write a function that will evaluate a poker hand and return its rank.
#
# Example:
# Hand: Ah As 10c 7d 6s // returns 'Pair of Aces'
# Hand: Kh Kc 3s 3h 2d // returns '2 Pair'
# Hand: Kh Qh 6h 2h 9h // returns 'Flush'
#
# Poker Hand Rankings: https://en.wikipedia.org/wiki/List_of_poker_hands
require 'pry'

class PokerHandEval
  attr_reader :hand

  def initialize(hand)
    @hand = hand
  end

  def evaluate
    if validate_hand
      determine_hand
    else
      return "I'm sorry, that hand is invalid"
    end
  end

  # Not taking into account duplicate cards yet
  def validate_hand
    if hand.length != 5 || !validate_cards
      return false
    else
      true
    end
  end

  def validate_cards
    valid = true
    hand.each do |card|
      unless library_of_values[card[0..-2].to_sym] && library_of_suites[card[-1].to_sym]
        valid = false
      end
    end
    valid
  end

  def determine_hand
    if sequenced && suited
      return 'Straight Flush'
    elsif four_pair
      return 'Four of a Kind'
    elsif full_house
      return 'Full House'
    elsif suited
      return 'Flush'
    elsif sequenced
      return 'Straight'
    elsif three_of_a_kind
      return 'Three of a Kind'
    elsif two_pair
      return 'Two Pair'
    elsif one_pair
      value = pair_value
      return "Pair of #{library_of_values[value.to_sym]}s"
    elsif high_card
      return "High Card, #{high_card}"
    end
  end

  def four_pair
    values = collect_values
    counts = Hash.new 0
    values.each do |value|
      counts[value] += 1
    end
    if counts.max_by{|k,v| v}[1] == 4
      true
    else
      false
    end
  end

  def full_house
    values = collect_values
    counts = Hash.new 0
    values.each do |value|
      counts[value] += 1
    end
    if counts.length == 2
      true
    else
      false
    end
  end

  def three_of_a_kind
    values = collect_values
    counts = Hash.new 0
    values.each do |value|
      counts[value] += 1
    end
    if counts.length > 2 && counts.max_by{|k,v| v}[1] == 3
      true
    else
      false
    end
  end

  def two_pair
    values = collect_values
    counts = Hash.new 0
    values.each do |value|
      counts[value] += 1
    end
    if counts.length == 3 && counts.max_by{|k,v| v}[1] == 2
      true
    else
      false
    end
  end

  def one_pair
    values = collect_values
    counts = Hash.new 0
    values.each do |value|
      counts[value] += 1
    end
    if counts.length == 4 && counts.max_by{|k,v| v}[1] == 2
      true
    else
      false
    end
  end

  def pair_value
    values = collect_values
    counts = Hash.new 0
    values.each do |value|
      counts[value] += 1
    end
    return counts.max_by{|k,v| v}[0]
  end

  def high_card
    values = collect_numerical_values.sort
    high_value = numeric_values.key(values[4])
    return library_of_values[high_value]
  end

  def collect_numerical_values
    values = collect_values
    return values.map {|value| numeric_values[value.to_sym]}
  end

  def total_occurrences
    values = collect_values
    counts = Hash.new 0
    values.each do |value|
      counts[value] += 1
    end
  end

  def sequenced
    sequenced = true
    values = collect_values
    num_values = (values.map { |value| numeric_values[value.to_sym] }).sort
    unless num_values[4] == (num_values[0] + 4)
      sequenced = false
    end
    sequenced
  end

  def collect_values
    hand.collect { |r| r[0..-2] }
  end

  def suited
    suit = hand[0][-1]
    same_suit = true
    hand.each do |card|
      unless card[-1] == suit
        same_suit = false
      end
    end
    same_suit
  end

  def library_of_values
    {
      'A': 'Ace',
      'K': 'King',
      'Q': 'Queen',
      'J': 'Jack',
      '10': 'Ten',
      '9': 'Nine',
      '8': 'Eight',
      '7': 'Seven',
      '6': 'Six',
      '5': 'Five',
      '4': 'Four',
      '3': 'Three',
      '2': 'Two'
    }
  end

  def library_of_suites
    {
      'd': 'diamonds',
      'h': 'hearts',
      's': 'spades',
      'c': 'clubs'
    }
  end

  def numeric_values
    {
      'A': 14,
      'K': 13,
      'Q': 12,
      'J': 11,
      '10': 10,
      '9': 9,
      '8': 8,
      '7': 7,
      '6': 6,
      '5': 5,
      '4': 4,
      '3': 3,
      '2': 2,
    }
  end
end
