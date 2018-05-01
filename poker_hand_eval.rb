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
    case hand
    when sequenced && suited
      return 'Straight Flush'
    end
  end

  def straight_flush

  end

  def sequenced
    sequenced = true
    values = hand.collect { |r| r[0..-2] }
    num_values = (values.map { |value| numeric_values[value.to_sym] }).sort
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
