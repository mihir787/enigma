require_relative 'decryptor'
class Crack

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
        output(decrypted_message)
        print_results(key)
        break
      end
    end
  end
  
end

if __FILE__ == $0
  encrypted_file_name = ARGV[0]
  cracked_file_name = ARGV[1]
  date = ARGV[2]

  Crack.new(encrypted_file_name, cracked_file_name, date).crack
end


#each encrypted message ends with "..end.."
# ruby ./lib/crack.rb encrypted.txt cracked.txt 030415
# Created 'cracked.txt' with the cracked key 82648 and date 030415


# take in input
#
# grab the last 7 characters of input which should be: ..end..
#
# ("0".."99999").each
#   -if digit is less than 4 digits, pad with zeros(method)
#
#     -create instance of decrypt
#     -pass in key and date
#     -if decrypted[-7..-1] = "..end.." then stop and that is your key
#     -otherwise increment
