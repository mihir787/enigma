require_relative 'date_offset'
require_relative 'rotation_calculator'
require_relative 'rotor'
require_relative 'decryptor'

class Decryptor
  attr_reader :encrypted_file_name, :decrypted_file_name, :key, :date

  def initialize(encrypted_file_name, decrypted_file_name, key, date)
    @encrypted_file_name = encrypted_file_name
    @decrypted_file_name = decrypted_file_name
    @key = key
    @date = date
  end

  def decrypt
    encrypted_message = read_file
    decrypted_message = rotate(encrypted_message, generate_offsets, :decrypt)
    output(decrypted_message)
    print_info
  end

  def generate_offsets
    date_offset = DateOffset.new(@date).calculate_date_offset
    rotation_calculator = RotationCalculator.new(@key.chars, date_offset).aggregate_rotations_guide
  end

  def rotate(message, rotation_calculator, task)
    encrypted_message = Rotor.new.rotate(message, rotation_calculator, task)
  end

  def print_info
    puts "Created '#{@decrypted_file_name}' with the key #{@key} and date #{@date}"
  end

  def output(decrypted_message)
    file = File.open(@decrypted_file_name, 'w') do |file|
      file.write(decrypted_message)
    end
  end

  def read_file
    File.open(encrypted_file_name).read
  end

end
