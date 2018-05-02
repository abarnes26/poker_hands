require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

require_relative 'poker_hand_eval'

class PokerHandTest < Minitest::Test

  def test_card_validator_valid
    hand = PokerHandEval.new(['Ah','As','10c','7d','6s']).validate_cards
    assert_equal true, hand
  end

  def test_card_validator_invalid
    hand = PokerHandEval.new(['Ah','s3','10c','7d','6s']).validate_cards
    assert_equal false, hand
  end

  # 'suited' means all the same suit
  def test_it_can_tell_if_a_suited_hand_is_suited
    hand = PokerHandEval.new(['Ah','3h','10h','7h','6h']).suited
    assert_equal true, hand
  end

  def test_it_can_tell_if_a_non_suited_hand_is_suited
    hand = PokerHandEval.new(['Ad','3s','10c','7h','6h']).suited
    assert_equal false, hand
  end

  def test_it_can_tell_if_an_sequenced_hand_is_sequenced
    hand = PokerHandEval.new(['Ad','10s','Jc','Qh','Kh']).sequenced
    hand2 = PokerHandEval.new(['9d','5s','6c','8h','7h']).sequenced
    assert_equal true, hand
    assert_equal true, hand2
  end

  def test_it_can_tell_if_an_non_sequenced_hand_is_sequenced
    hand = PokerHandEval.new(['Ad','5s','Jc','Qh','2h']).sequenced
    hand2 = PokerHandEval.new(['9d','Js','6c','8h','7h']).sequenced
    assert_equal false, hand
    assert_equal false, hand2
  end

  def test_straight_flush
    hand = PokerHandEval.new(['Ah','Kh','Qh','Jh','10h']).evaluate
    assert_equal 'Straight Flush', hand
  end

  def test_four_of_a_kind
    hand = PokerHandEval.new(['Ah','Ad','Ac','As','10h']).evaluate
    assert_equal 'Four of a Kind', hand
  end

  def test_full_house
    hand = PokerHandEval.new(['Ah','Ad','Ac','Ks','Kh']).evaluate
    assert_equal 'Full House', hand
  end

  def test_flush
    hand = PokerHandEval.new(['Ah','9h','3h','4h','6h']).evaluate
    assert_equal 'Flush', hand
  end

  def test_straight
    hand = PokerHandEval.new(['Jh','10c','9s','8d','7h']).evaluate
    assert_equal 'Straight', hand
  end

  def test_three_of_a_kind
    hand = PokerHandEval.new(['9h','9c','9s','6d','2h']).evaluate
    assert_equal 'Three of a Kind', hand
  end

  def test_two_pair
    hand = PokerHandEval.new(['9h','9c','5s','5d','2h']).evaluate
    assert_equal 'Two Pair', hand
  end

  def test_one_pair_of_2s
    hand = PokerHandEval.new(['Jh','5c','2s','Kd','2h']).evaluate
    assert_equal 'Pair of Twos', hand
  end

  def test_one_pair_of_As
    hand = PokerHandEval.new(['Ah','9c','5s','Ad','2h']).evaluate
    assert_equal 'Pair of Aces', hand
  end

  def test_high_card_K
    hand = PokerHandEval.new(['Ah','9c','5s','3d','2h']).evaluate
    assert_equal 'High Card, Ace', hand
  end

  def test_high_card_10
    hand = PokerHandEval.new(['9h','10c','5s','8d','2h']).evaluate
    assert_equal 'High Card, Ten', hand
  end

end
