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
  #
  # def test_two_pair
  #   hand = PokerHandEval.new(['Kh','Kc','3s','3h','2d']).evaluate
  #   assert_equal '2 pair', hand
  # end
  #
  # def test_flush
  #   hand = PokerHandEval.new(['Kh','Qh','6h','2h','9h']).evaluate
  #   assert_equal 'Flush', hand
  # end

end
