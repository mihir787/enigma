require_relative 'character_map'
require 'pry'

class Rotor
  attr_reader :character_map

  def initialize
    @character_map = CharacterMap.generate_map
  end

  def rotate(message, rotation_scale, task)
    formated = format_message(message)
    updated_indexes = collect_updated_index_value(formated, rotation_scale, task)
    updated_message(updated_indexes)
  end

  def format_message(message)
    formatted_message = []
    message.chars.each_slice(4) do |set|
      formatted_message << set
    end
    formatted_message
  end

  def valid_character?(character)
    @character_map.index(character) != nil
  end

  def current_character_index(char)
    @character_map.index(char)
  end

  def change_index_for_encryption(char, index, rotation_scale)
    ((current_character_index(char) + rotation_scale[index]) % 39)
  end

  def change_index_for_decryption(char, index, rotation_scale)
    subtracted_index = (current_character_index(char) - rotation_scale[index])
    if subtracted_index < 0
      (subtracted_index.abs % 39) * -1
    else
      subtracted_index % 39
    end
  end

  def update_index_value(char, index, rotation_scale, task)
    if task == :encrypt
      change_index_for_encryption(char, index, rotation_scale)
    else
      change_index_for_decryption(char, index, rotation_scale)
    end
  end

  def collect_updated_index_value(formatted_message, rotation_scale, task)
    updated_index_values = []
    formatted_message.each do |set|
      set.each.with_index do |char, index|
        updated_index_values << update_index_value(char, index, rotation_scale, task)  if valid_character?(char)
      end
    end
    updated_index_values
  end

  def updated_message(new_index_values)
    updated_message = new_index_values.map do |index|
      @character_map[index]
    end
    updated_message.join
  end
end
