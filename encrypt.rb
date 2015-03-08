require_relative './lib/key'
require_relative './lib/date_offset'
require_relative './lib/encryptor'
require_relative './lib/rotation_calculator'
require_relative './lib/rotor'
require 'pry'
require 'pry-byebug'

message_file = ARGV[0]
encrypted_file = ARGV[1]
Encryptor.new(message_file, encrypted_file).encrypt


# decrypt = Decryptor.new('to08vvm2z5z8p9mbyo1byuplj', './decrypted.txt', "41521", "020315").decrypt
