require 'minitest/autorun'
require 'minitest/pride'
require '../lib/key'

class KeyTest < Minitest::Test


  def test_it_exists
    key = Key.new
    assert key
  end

  # def test_it_returns_an_empty_array (NO Longer APplicable)
  #   key = Key.new
  #   assert key.generate_key.empty?
  # end

  # def test_generates_one_random_number
  #   not sure how to test
  #   key = Key.new
  #   assert key.generate_key.all? {|n| n < 10 && n >= 0}
  # end

  def test_generates_five_random_numbers
    key1 = Key.new
    key2 = Key.new
    #note that this doesnt necessisarily test random, comeback to
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
