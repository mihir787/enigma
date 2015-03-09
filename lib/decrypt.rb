require_relative 'decryptor'

encrypted_file_name = ARGV[0]
decrypted_file_name = ARGV[1]
key = ARGV[2]
date = ARGV[3]

Decryptor.new(encrypted_file_name, decrypted_file_name, key, date).decrypt
