require_relative 'test_helper'
require_relative '../lib/decryptor'

class DecryptorTest < Minitest::Test

  def setup
    @test_file = File.new("test_file.txt", "w+")
    @test_file.write("ruby is awesome")
    @test_file.close
    @test_file2 = File.new("test_file2.txt", "w+")
    @test_file2.write("ruby is awesome 2")
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
  




end
