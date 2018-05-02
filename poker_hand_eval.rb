# Write a function that will evaluate a poker hand and return its rank.
#
# Example:
# Hand: Ah As 10c 7d 6s // returns 'Pair of Aces'
# Hand: Kh Kc 3s 3h 2d // returns '2 Pair'
# Hand: Kh Qh 6h 2h 9h // returns 'Flush'
#
# Poker Hand Rankings: https://en.wikipedia.org/wiki/List_of_poker_hands

require 'pry'
require_relative 'poker_hand_eval_helpers'
require_relative 'poker_eval_libraries'

class PokerHandEval < PokerEvalHelpers
  include PokerEvalLibraries
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

  def determine_hand
    occurrences = total_occurrences(collect_values)
    if sequenced && suited
      return 'Straight Flush'
    elsif four_pair(occurrences)
      return 'Four of a Kind'
    elsif full_house(occurrences)
      return 'Full House'
    elsif suited
      return 'Flush'
    elsif sequenced
      return 'Straight'
    elsif three_of_a_kind(occurrences)
      return 'Three of a Kind'
    elsif two_pair(occurrences)
      return 'Two Pair'
    elsif one_pair(occurrences)
      value = pair_value(occurrences)
      return "Pair of #{library_of_values[value.to_sym]}s"
    elsif high_card
      return "High Card, #{high_card}"
    end
  end

  def four_pair(occurrences)
    if occurrences.max_by{|k,v| v}[1] == 4
      true
    else
      false
    end
  end

  def full_house(occurrences)
    if occurrences.length == 2
      true
    else
      false
    end
  end

  def three_of_a_kind(occurrences)
    if occurrences.length > 2 && occurrences.max_by{|k,v| v}[1] == 3
      true
    else
      false
    end
  end

  def two_pair(occurrences)
    if occurrences.length == 3 && occurrences.max_by{|k,v| v}[1] == 2
      true
    else
      false
    end
  end

  def one_pair(occurrences)
    if occurrences.length == 4 && occurrences.max_by{|k,v| v}[1] == 2
      true
    else
      false
    end
  end

  def pair_value(occurrences)
    occurrences.max_by{|k,v| v}[0]
  end

  def high_card
    values = collect_numerical_values.sort
    high_value = numeric_values.key(values[4])
    library_of_values[high_value]
  end

  def sequenced
    sequenced = true
    num_values = collect_numerical_values.sort
    unless num_values[4] == (num_values[0] + 4)
      sequenced = false
    end
    sequenced
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
end
