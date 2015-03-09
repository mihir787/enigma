require_relative 'cracker'

encrypted_file_name = ARGV[0]
cracked_file_name = ARGV[1]
date = ARGV[2]

Cracker.new(encrypted_file_name, cracked_file_name, date).crack
