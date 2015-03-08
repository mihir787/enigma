require_relative 'test_helper'
require_relative '../lib/character_map'

class CharacterMapTest < Minitest::Test

  def setup
    @char_map = CharacterMap.new
  end

  def test_character_map_exists
    assert @char_map
  end

  def test_that_generates_character_map_array
    assert_equal ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", " ", ".", ","], @char_map.generate_map
  end
end
