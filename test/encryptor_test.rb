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

  def test_it_can_encrypt
    File.new("test_file4.txt", "w+")
    encryptor = Encryptor.new("test_file.txt", "test_file4.txt")
    encryptor.key = %w(1 5 9 3 0)
    encryptor.encrypt("031015")
    assert_equal "6dsum496pfvo38v", File.open("test_file4.txt").read
  end

  def test_it_can_encrypt_another_file
    encryptor = Encryptor.new("test_file2.txt", "test_file3.txt")
    encryptor.key = %w(9 9 9 4 0)
    encryptor.encrypt("031115")
    assert_equal ",et4s5 dvgwy99wdk", File.open("test_file3.txt").read
  end

  def test_it_can_encrypt_empty_message_by_returing_empty_file
    File.new("test_file4.txt", "w+")
    encryptor = Encryptor.new("test_file3.txt", "test_file4.txt")
    encryptor.key = %w(0 0 9 3 0)
    encryptor.encrypt("031015")
    assert File.open("test_file4.txt").read.empty?
  end

end
