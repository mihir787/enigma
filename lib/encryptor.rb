require_relative 'key'

class Encryptor
  attr_reader :message

  def initialize(input, encryption_file)
    @message = input
    @encryption_file = encyrption_file
  end

  def encrypt
    key = Key.new
    date_offset = DateOffset.new
    date_offset.calculate_date_offset
    rotation_calculator = RotationCalculator.new(key.rand_key, date_offset.calculate_date_offset)
    rotation_calculator.aggregate_rotations_guide
    rotor = Rotor.new
    rotor.rotate(@message, rotation_calculator.aggregate_rotations_guide, :encrypt)
  end


end

# I. take in input (X)
# II. generate key and date offset (X)
# III. find rotation calculation(X)
# IV. rotate- which returns strings
# V. put the returned string from rotate in the decrypt.txt file
# VI. print game info ex.
# Created 'encrypted.txt' with the key 82648 and date 030415
#
#
# asssume the input coming in is array of chars
