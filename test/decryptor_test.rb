require_relative 'test_helper'
require_relative '../lib/decryptor'

class DecryptorTest < Minitest::Test

  def setup
    @test_file = File.new("test_file.txt", "w+")
    @test_file.write("ruby is awesome")
    @test_file.close
    @test_file2 = File.new("test_file2.txt", "w+")
    @test_file2.write("i love spongebob square pants, because he is cool..end..")
    @test_file2.close
    @test_file3 = File.new("test_file3.txt", "w+")
    @test_file3.close

    @key = "24384"
    @date = "080315"
  end

  def teardown
    File.delete("test_file.txt")
    File.delete("test_file2.txt")
    File.delete("test_file3.txt")
  end

  def test_it_exists
    assert Decryptor.new(@test_file, @test_file2, @key, @date)
  end

  def test_initializes_with_input_file_names_date_and_key
    decryptor = Decryptor.new("file.txt", "file2.txt", @key, @date)
    assert_equal "file.txt", decryptor.encrypted_file_name
    assert_equal "file2.txt", decryptor.decrypted_file_name
    assert_equal "24384", decryptor.key
    assert_equal "080315", decryptor.date
  end

  def test_it_can_decrypt
    decryptor = Decryptor.new("test_file.txt", "test_file3.txt", @key, @date)
    decryptor.decrypt
    assert_equal 15, File.open("test_file3.txt").read.size
  end


end
