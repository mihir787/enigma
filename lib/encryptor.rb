require_relative 'date_offset'
require_relative 'rotation_calculator'
require_relative 'rotor'
require_relative 'encryptor'
require_relative 'key'

class Encryptor

  attr_reader :message_file_name, :encrypted_file_name

  def initialize(message_file_name, encrypted_file_name)
    @message_file_name = message_file_name
    @encrypted_file_name = encrypted_file_name
  end

  def encrypt
    encrypted_message = rotate(read_file, generate_offsets, :encrypt)
    output(encrypted_message)
  end

  def generate_offsets
    key = Key.new.rand_key
    date_offset = DateOffset.new
    calculated_date_offset = date_offset.calculate_date_offset
    print_offsets(key.join, date_offset.given_date)
    rotation_calculator = RotationCalculator.new(key, calculated_date_offset).aggregate_rotations_guide
  end

  def rotate(message, rotation_calculator, task)
    encrypted_message = Rotor.new.rotate(message, rotation_calculator, task)
  end

  def print_offsets(key, date)
    puts "Created '#{@encrypted_file_name}' with the key #{key} and date #{date}"
  end

  def output(encrypted_message)
    file = File.open(@encrypted_file_name, 'w') do |file|
      file.write(encrypted_message)
    end
  end

  def read_file
    File.open(message_file_name).read
  end
end

if __FILE__ == $0
  message_file_name = ARGV[0]
  encrypted_file_name = ARGV[1]
  Encryptor.new(message_file_name, encrypted_file_name).encrypt
end
