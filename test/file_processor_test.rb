require_relative 'test_helper'
require_relative '../lib/file_processor'

class FileProcessorTest < Minitest::Test

  def setup
    @test_file = File.new("test_file.txt", "w+")
    @test_file.write("ruby is awesome ..end..")
    @test_file.close
    @test_file2 = File.new("test_file2.txt", "w+")
    @test_file2.write("ruby is awesome 2 ..end..")
    @test_file2.close
    @test_file3 = File.new("test_file3.txt", "w+")
    @test_file3.close
  end

  def teardown
    File.delete("test_file.txt")
    File.delete("test_file2.txt")
    File.delete("test_file3.txt")
  end

  def test_that_file_can_be_read
    assert_equal "ruby is awesome ..end..", FileProcessor.read_file("test_file.txt")
    assert_equal "ruby is awesome 2 ..end..", FileProcessor.read_file("test_file2.txt")
    assert FileProcessor.read_file("test_file3.txt").empty?
  end

  def test_file_can_be_written
    FileProcessor.output("test_file3.txt", "fish..end..")
    assert_equal "fish..end..", FileProcessor.read_file("test_file3.txt")
  end

end
