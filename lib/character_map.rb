class CharacterMap

  def generate_map
    ('a'..'z').to_a + %w(0 1 2 3 4 5 6 7 8 9) + [' ', '.', ',']
  end
end
