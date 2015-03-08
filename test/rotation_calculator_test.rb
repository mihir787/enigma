require_relative 'test_helper'
require_relative '../lib/rotation_calculator'

class RotationCalculatorTest < Minitest::Test

  def test_it_exists
    rot_calc = RotationCalculator.new
    assert rot_calc
  end

  def test_it_takes_in_key_and_date_offset
    date_offset = %w(0 2 3 9)
    key = %w(1 8 7 9 4)
    rot_calc = RotationCalculator.new(key, date_offset)
    assert rot_calc
  end


  def test_combine_generating_key_rotation
    date_offset = %w(0 2 3 9)
    key = %w(1 8 7 9 4)
    rot_calc = RotationCalculator.new(key, date_offset)
    assert_equal %w(18 87 79 94), rot_calc.key_rotation(key)
  end


  def test_combine_both_key_and_date_offset
    date_offset = %w(0 2 3 9)
    key = %w(1 8 7 9 4)
    rot_calc = RotationCalculator.new(key, date_offset)
    assert_equal [18, 89, 82, 103], rot_calc.combine_rotations(%w(18 87 79 94), date_offset)
  end

  def test_aggregate_rotation_guide
    date_offset = %w(0 2 3 9)
    key = %w(1 8 7 9 4)
    rot_calc = RotationCalculator.new(key, date_offset)
    assert_equal 82, rot_calc.aggregate_rotations_guide[2]
    assert_equal 4, rot_calc.aggregate_rotations_guide.size
  end
end
