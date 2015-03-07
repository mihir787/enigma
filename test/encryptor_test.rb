require 'minitest/autorun'
require 'minitest/pride'
require '../lib/encryptor'

class EncryptorTest < Minitest::Test

  def test_it_exists
    input = %w(r u b y)
    encryptor = Encryptor.new(input)
    assert encryptor
  end

  def test_initializes_with_input_message_as_array_of_chars
    input = %w(r u b y)
    encryptor = Encryptor.new(input)
    assert_equal %w(r u b y), encryptor.message
  end

  # def test_generates_random_key
  #   input = %w(r u b y)
  #   encryptor = Encryptor.new(input)
  #   refute_equal [1, 1, 1, 1, 1], encryptor.encrypt
  # end
end
