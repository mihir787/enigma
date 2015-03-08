require_relative 'test_helper'
require_relative '../lib/rotor'

class RotorTest < Minitest::Test

  def test_it_exists
    rotor = Rotor.new
    assert rotor
  end

  def test_character_map_is_initialized
    rotor = Rotor.new
    assert_equal 39, rotor.character_map.size
  end

  def test_valid_character
    rotor = Rotor.new
    assert_equal 37, rotor.character_map.index(".")
    assert rotor.valid_character?(".")
    refute rotor.valid_character?("!")
  end

  def test_string_message_can_be_converted_into_array_of_sets_of_four
    rotor = Rotor.new
    message = "Go fetch the ball."
    assert_equal [["G", "o", " ", "f"], ["e", "t", "c", "h"], [" ", "t", "h", "e"], [" ", "b", "a", "l"], ["l","."]], rotor.format_message(message)
  end

  def test_rotate_index_for_encryption
    rotor = Rotor.new
    assert_equal 37, rotor.rotate_index_for_encryption("u", 1, {"0"=>50, "1"=>17, "2"=>54, "3"=>26})
  end

  def test_rotate_index_for_decryption
    rotor = Rotor.new
    assert_equal 20, rotor.rotate_index_for_decryption(".", 1, {"0"=>50, "1"=>17, "2"=>54, "3"=>26})
  end

  def test_update_index_value_for_encrypt
    rotor = Rotor.new
    assert_equal 37, rotor.update_index_value("u", 1, {"0"=>50, "1"=>17, "2"=>54, "3"=>26}, :encrypt)
  end

  def test_update_index_value_for_decrypt
    rotor = Rotor.new
    assert_equal 20, rotor.update_index_value(".", 1, {"0"=>50, "1"=>17, "2"=>54, "3"=>26}, :decrypt)
  end

  def test_collect_updated_index_values
    rotor = Rotor.new
    assert_equal [28, 37, 16, 11], rotor.collect_updated_index_value([["r", "u", "b", "y"]], {"0"=>50, "1"=>17, "2"=>54, "3"=>26}, :encrypt)
    assert_equal [-22, 20, -38, -15], rotor.collect_updated_index_value([["2", ".", "q", "l"]], {"0"=>50, "1"=>17, "2"=>54, "3"=>26}, :decrypt)
  end

  def test_message_updates
    rotor = Rotor.new
    assert_equal "2.ql", rotor.updated_message([28, 37, 16, 11])
    assert_equal "ruby", rotor.updated_message([-22, 20, -38, -15])
  end

  def test_rotate
    rotor = Rotor.new
    assert_equal "2.ql", rotor.rotate("ruby", {"0"=>50, "1"=>17, "2"=>54, "3"=>26}, :encrypt)
    assert_equal "ruby", rotor.rotate("2.ql", {"0"=>50, "1"=>17, "2"=>54, "3"=>26}, :decrypt)
    assert_equal "2.ql2.ql2", rotor.rotate("rubyrubyr", {"0"=>50, "1"=>17, "2"=>54, "3"=>26}, :encrypt)
  end

end
