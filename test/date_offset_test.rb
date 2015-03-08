require_relative 'test_helper'
require_relative '../lib/date_offset'

class DateOffsetTest < Minitest::Test

  def test_it_exists
    date_offset = DateOffset.new
    assert date_offset
  end

  def test_it_can_format_date_in_DDMMYY_form
    date = Time.gm(2015, 03, 03)
    date_offset = DateOffset.new
    assert_equal "030315", date_offset.format_numerically(date)
  end

  def test_it_remove_leading_zeros
    date_offset = DateOffset.new
    date = Time.gm(2015, 03, 03)
    date_offset.format_numerically(date)
    assert_equal 30315, date_offset.remove_leading_zero
  end

  def test_it_can_square_a_value
    date_offset = DateOffset.new
    assert_equal 64, date_offset.square(8)
  end

  def test_it_can_splice_last_four_digits
    date_offset = DateOffset.new
    assert_equal "6566", date_offset.splice_final_four(1446566)
  end

  # def test_can_caluculate_date_offset
  #   #not sure how to test this
  #   skip
  #   date_offset = DateOffset.new
  #   date = Time.gm(2015, 03, 03)
  # end

  def test_can_take_in_a_date_when_initialized
    date_offset = DateOffset.new("030315")
    assert date_offset
  end

  def test_date_provided
    date_offset = DateOffset.new(030315)
    refute date_offset.date_not_provided?
  end

  def test_date_provided_remove_leading_zero
    date_offset = DateOffset.new("030315")
    assert_equal 30315, date_offset.remove_leading_zero
  end

  def test_calculate_date_offset_for_known_date
    date_offset = DateOffset.new("171289")
    assert_equal ["1", "5", "2", "1"], date_offset.calculate_date_offset
    assert_equal "171289", date_offset.given_date
  end

  def test_calculate_date_offset_for_known_date
    date_offset = DateOffset.new("020315")
    assert_equal ["9", "2", "2", "5"], date_offset.calculate_date_offset
    assert_equal "020315", date_offset.given_date
  end

end

#how can you test todays date?
