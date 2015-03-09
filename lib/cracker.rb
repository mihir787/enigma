require_relative 'decryptor'
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

  def decrypt(key)
    decryptor = Decryptor.new(encrypted_file_name, cracked_file_name, key, date)
    decrypted_message = decryptor.rotate(decryptor.read_file, decryptor.generate_offsets, :decrypt)
  end

  def match?(decrypted_message)
    decrypted_message[-7..-1] == "..end.."
  end

  def print_results(key)
    puts "Created '#{@cracked_file_name}' with the cracked key #{key} and date #{@date}"
  end

  def output(cracked_message)
    file = File.open(@cracked_file_name, 'w') do |file|
      file.write(cracked_message)
    end
  end

  def crack
    ("0".."99999").each do |n|
      key = pad_zeros(n)
      decrypted_message = decrypt(key)
      if match?(decrypted_message)
        print_results(key)
        output(decrypted_message)
        break
      end
    end
  end

end
