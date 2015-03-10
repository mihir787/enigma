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
    @key = Key.new.rand_key
    @date_offset = DateOffset.new
  end

  def encrypt
    print_offsets(@key.join, @date_offset.today_date)
    rotation_guide = RotationCalculator.new(@key, @date_offset.calculate_date_offset).aggregate_rotations_guide
    encrypted_message = Rotor.new.rotate(read_file, rotation_guide, :encrypt)
    output(encrypted_message)
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
