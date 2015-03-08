require_relative './lib/date_offset'
require_relative './lib/rotation_calculator'
require_relative './lib/rotor'
require_relative './lib/decryptor'
require 'pry'
require 'pry-byebug'

encrypted_file_name = ARGV[0]
decrypted_file_name = ARGV[1]
key = ARGV[2]
date = ARGV[3]

Decryptor.new(encrypted_file_name, decrypted_file_name, key, date).decrypt
