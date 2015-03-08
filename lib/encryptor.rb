class Encryptor

  attr_reader :message_file_name

  def initialize(message_file_name, encrypted_file_name)
    @message_file_name = message_file_name
    @encrypted_file_name = encrypted_file_name
  end

  def encrypt
    key = Key.new.rand_key
    puts key
    date_offset = DateOffset.new.calculate_date_offset
    rotation_calculator = RotationCalculator.new(key, date_offset).aggregate_rotations_guide
    message = read_file
    rotor = Rotor.new
    encrypted_message = rotor.rotate(message, rotation_calculator, :encrypt)
    output(encrypted_message)
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
