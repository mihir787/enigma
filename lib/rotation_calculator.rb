class RotationCalculator

  def initialize(key = nil, date_offset = nil)
    @key = key
    @date_offset = date_offset
  end

  def key_rotation(key = @key)
    key_rotation = key.map.with_index do |n, index|
      if index < 4
        n + @key[index + 1]
      end
    end
    key_rotation.pop
    key_rotation
  end

  def combine_rotations(key_rot, date_offset)
    combo = key_rot.zip(date_offset)
    combo.map!{|n| n[0].to_i + n[1].to_i}
  end

  def aggregate_rotations_guide(key = @key, date_offset = @date_offset)
    combo = combine_rotations(key_rotation(key), date_offset)
    {0 => combo[0], 1 => combo[1], 2 => combo[2], 3 => combo[3]}
  end
end
