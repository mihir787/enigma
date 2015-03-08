require_relative 'test_helper'
require_relative '../lib/encryptor'

class EncryptorTest < Minitest::Test

  def setup
    @test_file = File.new("test_file.txt", "w+")
    @test_file.write("ruby is awesome")
    @test_file.close
    @test_file2 = File.new("test_file2.txt", "w+")
    @test_file2.write("ruby is awesome 2")
    @test_file2.close
  end

  def teardown
    File.delete("test_file.txt")
    File.delete("test_file2.txt")
  end

  def test_it_exists
    skip
    input = %w(r u b y)
    encryptor = Encryptor.new(input)
    assert encryptor
  end

  def test_initializes_with_input_message_as_array_of_chars
    skip
    input = %w(r u b y)
    encryptor = Encryptor.new(input)
    assert_equal %w(r u b y), encryptor.message
  end

  def test_it_can_read_contents_of_file
    @encryptor = Encryptor.new("test_file.txt", "test_encrypted.txt")

    assert_equal "ruby is awesome", @encryptor.read_file
  end

  def test_it_can_read_contents_of_another_file
    @encryptor = Encryptor.new("test_file2.txt", "test_encrypted.txt")

    assert_equal "ruby is awesome 2", @encryptor.read_file
  end



  # def test_generates_random_key
  #   input = %w(r u b y)
  #   encryptor = Encryptor.new(input)
  #   refute_equal [1, 1, 1, 1, 1], encryptor.encrypt
  # end
end
