class PokerEvalHelpers

  # Not taking into account duplicate cards yet
  def validate_hand
    if hand.length != 5 || !validate_cards
      false
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

  def collect_numerical_values
    collect_values.map {|value| numeric_values[value.to_sym]}
  end

  def total_occurrences(values)
    counts = Hash.new 0
    values.each do |value|
      counts[value] += 1
    end
    counts
  end

  def collect_values
    hand.collect { |r| r[0..-2] }
  end

end
