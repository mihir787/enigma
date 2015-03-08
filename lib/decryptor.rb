class Decryptor
  attr_reader :encrypted_file_name

  def initialize(encrypted_file_name, decrypted_file_name, key, date)
    @encrypted_file_name = encrypted_file_name
    @decrypted_file_name = decrypted_file_name
    @key = key
    @date = date
  end

  def decrypt
    date_offset = DateOffset.new(@date).calculate_date_offset
    encrypted_message = read_file
    rotation_calculator = RotationCalculator.new(@key.chars, date_offset).aggregate_rotations_guide
    decrypted_message = Rotor.new.rotate(encrypted_message, rotation_calculator, :decrypt)
    output(decrypted_message)
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
