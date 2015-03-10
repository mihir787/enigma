require_relative 'date_offset'
require_relative 'rotation_calculator'
require_relative 'rotor'
require_relative 'encryptor'
require_relative 'key'
require_relative 'file_processor'

class Encryptor

  attr_reader :message_file_name, :encrypted_file_name
  attr_accessor :key

  def initialize(message_file_name, encrypted_file_name)
    @message_file_name = message_file_name
    @encrypted_file_name = encrypted_file_name
    @key = Key.new.rand_key
    @date_offset = DateOffset.new
  end

  def encrypt(date = @date_offset.today_date)
    print_offsets(@key.join, date)
    rotation_guide = RotationCalculator.new(@key, @date_offset.calculate_date_offset(date)).aggregate_rotations_guide
    encrypted_message = Rotor.new.rotate(FileProcessor.read_file(message_file_name), rotation_guide, :encrypt)
    FileProcessor.output(encrypted_file_name, encrypted_message)
  end

  def print_offsets(key, date)
    puts "Created '#{@encrypted_file_name}' with the key #{key} and date #{date}"
  end

end
