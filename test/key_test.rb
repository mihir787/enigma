require_relative 'test_helper'
require_relative '../lib/key'

class KeyTest < Minitest::Test


  def test_it_exists
    key = Key.new
    assert key
  end

  def test_generates_an_array_of_strings
    key1 = Key.new
    assert key1.generate_key.is_a? Array
    assert key1.generate_key.join.is_a? String
  end


  def test_generates_five_random_numbers
    key1 = Key.new.rand_key
    key2 = Key.new.rand_key
    refute key1.all? {|n| n == key1[0]}
    refute key1 == key2
  end

  def test_that_key_is_generated_when_initialized
    key = Key.new.rand_key
    assert 5, key.size
  end



end
