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
    @test_file3 = File.new("test_file3.txt", "w+")
    @test_file3.close
  end

  def teardown
    File.delete("test_file.txt")
    File.delete("test_file2.txt")
    File.delete("test_file3.txt")
  end

  def test_it_exists
    assert Encryptor.new(@test_file, @test_file2)
  end

  def test_initializes_with_input_file_names
    encryptor = Encryptor.new("file.txt", "file2.txt")
    assert_equal "file.txt", encryptor.message_file_name
    assert_equal "file2.txt", encryptor.encrypted_file_name
  end

  def test_it_can_read_contents_of_file
    encryptor = Encryptor.new("test_file.txt", "test_encrypted.txt")

    assert_equal "ruby is awesome", encryptor.read_file
  end

  def test_it_can_read_contents_of_another_file
    encryptor = Encryptor.new("test_file2.txt", "test_encrypted.txt")

    assert_equal "ruby is awesome 2", encryptor.read_file
  end

  def test_it_can_output_encrypted_message
    message = "r1e7"
    encryptor = Encryptor.new("file.txt", "test_file3.txt")
    encryptor.output("r1e7")
    assert_equal "r1e7", File.open("test_file3.txt").read
  end

  def test_it_can_encrypt
    encryptor = Encryptor.new("test_file.txt", "test_file3.txt")
    encryptor.encrypt
    assert_equal 15, File.open("test_file3.txt").read.size
  end

end
