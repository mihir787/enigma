require_relative 'test_helper'
require_relative '../lib/key'

class KeyTest < Minitest::Test


  def test_it_exists
    key = Key.new
    assert key
  end

  def test_generates_a_string
    key1 = Key.new
    assert key1.generate_key.is_a? Array
    assert key1.generate_key.join.is_a? String
  end


  def test_generates_five_random_numbers
    key1 = Key.new
    key2 = Key.new
    rand_key = key1.generate_key
    assert 5, rand_key.size
    refute rand_key.all? {|n| n == rand_key[0]}
    refute key1.rand_key == key2.rand_key
  end

  def test_that_key_is_generated_when_initialized
    key = Key.new
    assert 5, key.rand_key.size
  end



end
