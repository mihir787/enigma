require_relative 'cracker'

encrypted_file_name = ARGV[0]
cracked_file_name = ARGV[1]
date = ARGV[2]

Cracker.new(encrypted_file_name, cracked_file_name, date).crack


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
