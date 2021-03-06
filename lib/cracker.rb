require_relative 'date_offset'
require_relative 'rotation_calculator'
require_relative 'rotor'
require_relative 'file_processor'

class Cracker

  attr_reader :encrypted_file_name, :cracked_file_name, :date

  def initialize(encrypted_file_name, cracked_file_name, date)
    @encrypted_file_name = encrypted_file_name
    @cracked_file_name = cracked_file_name
    @date = date
  end

  def pad_zeros(number)
    number.rjust(5, "0")
  end

  def rotate(key)
    date_offset = DateOffset.new(@date).calculate_date_offset
    rotation_guide = RotationCalculator.new(key.chars, date_offset).aggregate_rotations_guide
    decrypted_message = Rotor.new.rotate(FileProcessor.read_file(encrypted_file_name), rotation_guide, :crack)
  end

  def match?(decrypted_message)
    decrypted_message[-7..-1] == "..end.."
  end

  def print_results(key)
    puts "Created '#{@cracked_file_name}' with the cracked key #{key} and date #{@date}"
  end

  def crack
    ("0".."99999").each do |n|
      key = pad_zeros(n)
      decrypted_message = rotate(key)
      if match?(decrypted_message)
        print_results(key)
        FileProcessor.output(cracked_file_name, decrypted_message)
        break
      end
    end
  end

end
