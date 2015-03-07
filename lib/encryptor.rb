require_relative 'key'
require_relative 'date_offset'
require_relative 'rotation_calculator'
require_relative 'rotor'

class Encryptor
  attr_reader :message

  def initialize(input, encryption_file)
    @message = input
    @encryption_file = encryption_file
  end

  def encrypt
    key = Key.new.rand_key
    puts key
    date_offset = DateOffset.new.calculate_date_offset
    rotation_calculator = RotationCalculator.new(key, date_offset).aggregate_rotations_guide
    rotor = Rotor.new
    encrypted_message = rotor.rotate(@message, rotation_calculator, :encrypt)
    output(encrypted_message)
  end

  def output(encrypted_message)
    file = File.open(@encryption_file, 'w') do |file|
      file.write(encrypted_message)
    end
  end
end

encrypt = Encryptor.new("rex, is the best.", "./encrypted.txt").encrypt

# I. take in input (X)
# II. generate key and date offset (X)
# III. find rotation calculation(X)
# IV. rotate- which returns strings
# V. put the returned string from rotate in the decrypt.txt file
# VI. print game info ex.
# Created 'encrypted.txt' with the key 82648 and date 030415
#
#
# asssume the input coming in is a string.
