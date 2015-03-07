class Key
  attr_reader :rand_key

  def initialize
    @rand_key = generate_key
  end

  def generate_key
    key = []
    5.times {key << rand(9).to_s}
    key
  end
end
