require_relative 'encryptor'

message_file_name = ARGV[0]
encrypted_file_name = ARGV[1]
Encryptor.new(message_file_name, encrypted_file_name).encrypt
