require_relative './lib/date_offset'
require_relative './lib/rotation_calculator'
require_relative './lib/rotor'
require_relative './lib/encryptor'
require 'pry'
require 'pry-byebug'

message_file_name = ARGV[0]
encrypted_file_name = ARGV[1]
Encryptor.new(message_file_name, encrypted_file_name).encrypt
