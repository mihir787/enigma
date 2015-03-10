require_relative 'date_offset'
require_relative 'rotation_calculator'
require_relative 'rotor'
require_relative 'decryptor'
require_relative 'file_processor'

class Decryptor
  attr_reader :encrypted_file_name, :decrypted_file_name, :key, :date

  def initialize(encrypted_file_name, decrypted_file_name, key, date)
    @encrypted_file_name = encrypted_file_name
    @decrypted_file_name = decrypted_file_name
    @key = key
    @date = date
  end

  def decrypt
    date_offset = DateOffset.new(@date).calculate_date_offset
    rotation_calculator = RotationCalculator.new(@key.chars, date_offset).aggregate_rotations_guide
    decrypted_message = Rotor.new.rotate(FileProcessor.read_file(encrypted_file_name), rotation_calculator, :decrypt)
    FileProcessor.output(decrypted_file_name, decrypted_message)
    print_info
  end

  def print_info
    puts "Created '#{decrypted_file_name}' with the key #{key} and date #{date}"
  end

end
