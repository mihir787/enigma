require_relative 'date_offset'
require_relative 'rotation_calculator'
require_relative 'rotor'

class Decryptor

  def initialize(message, decryption, key, date)
    @message = message
    @decryption_file = decryption
    @key = key
    @date = date
  end

  def decrypt
    date_offset = DateOffset.new(@date).calculate_date_offset
    rotation_calculator = RotationCalculator.new(@key.chars, date_offset).aggregate_rotations_guide
    decrypted_message = Rotor.new.rotate(@message, rotation_calculator, :decrypt)
    output(decrypted_message)
  end

  def output(decrypted_message)
    file = File.open(@decryption_file, 'w') do |file|
      file.write(decrypted_message)
    end
  end
end

decrypt = Decryptor.new('xurso84bnu4wk8nt', './decrypted.txt', "75316", "070315").decrypt
