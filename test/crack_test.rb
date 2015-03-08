require_relative 'test_helper'
require_relative '../lib/crack'

class CrackTest < Minitest::Test

  def setup
    @test_file = File.new("test_file.txt", "w+")
    @test_file.write("ruby is awesome ..end..")
    @test_file.close
    @test_file2 = File.new("test_file2.txt", "w+")
    @test_file2.write("ruby is awesome 2 ..end..")
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
    assert Crack.new("test_file.txt", "test_file2.txt", @date)
  end

  def test_it_takes_in_encrypted_file_and_reads_the_file
    crack = Crack.new("test_file.txt", "test_file2.txt", @date)
    assert_equal "ruby is awesome ..end..", crack.read_file(crack.encrypted_file_name)
  end

  def test_extraction_of_last_seven_chars
    message = "apples are super good ..end.."
    crack = Crack.new("test_file.txt", "test_file2.txt", @date)
    assert_equal "..end..", crack.extract_last_seven_characters(message)
  end

  def test_that_key_guess_can_be_padded_with_zeros
    number = "9"
    crack = Crack.new("test_file.txt", "test_file2.txt", @date)
    assert_equal "00009", crack.pad_zeros(number)
    assert_equal "12525", crack.pad_zeros("12525")
  end




end
