require_relative 'test_helper'
require_relative '../lib/cracker'

class CrackerTest < Minitest::Test

  def setup
    @test_file = File.new("test_file.txt", "w+")
    @test_file.write("ruby is awesome ..end..")
    @test_file.close
    @test_file2 = File.new("test_file2.txt", "w+")
    @test_file2.write("ruby is awesome 2 ..end..")
    @test_file2.close
    @test_file3 = File.new("test_file3.txt", "w+")
    @test_file3.close
    @test_file4 = File.new("test_file4.txt", "w+")
    @test_file4.write("v4l5v369wh9ygyk,bm9hbi75rn7z")
    @test_file4.close

    @key = "24384"
    @date = "080315"
  end

  def teardown
    File.delete("test_file.txt")
    File.delete("test_file2.txt")
    File.delete("test_file3.txt")
    File.delete("test_file4.txt")
  end


  def test_it_exists
    assert Cracker.new("test_file.txt", "test_file2.txt", @date)
  end

  def test_it_takes_in_encrypted_file_name_cracked_file_name_and_date
    crack = Cracker.new("test_file.txt", "test_file2.txt", @date)
    assert_equal "080315", crack.date
    assert_equal "test_file.txt", crack.encrypted_file_name
    assert_equal "test_file2.txt", crack.cracked_file_name
  end

  def test_that_key_guess_can_be_padded_with_zeros
    number = "9"
    crack = Cracker.new("test_file.txt", "test_file2.txt", @date)
    assert_equal "00009", crack.pad_zeros(number)
    assert_equal "12525", crack.pad_zeros("12525")
  end

  def test_match?
    crack = Cracker.new("test_file.txt", "test_file2.txt", @date)
    assert crack.match?("fish is good..end..")
    refute crack.match?("fish")
  end

  def test_output
    crack = Cracker.new("test_file.txt", "test_file3.txt", @date)
    crack.output("fish is great..end..")
    assert_equal "fish is great..end..", File.open("test_file3.txt").read
  end

  def test_decrypt
    crack = Cracker.new("test_file.txt", "test_file3.txt", @date)
    assert_equal ".k1gr.fsum4a8c4ss148x1y", crack.decrypt('10891')
  end

  def test_crack
    crack_test = Cracker.new("test_file4.txt", "test_file2.txt", @date)
    crack_test.crack
    assert_equal "rupert is a cool cat ..end..", File.open("test_file2.txt").read
  end


end
