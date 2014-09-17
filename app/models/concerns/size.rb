class Size
  include Comparable

  attr_reader :value

  def self.sizes
    { small: 0,
      medium: 1,
      large: 2 }
  end

  def initialize(size)
    self.value = size
  end

  def value=(new_size)
    raise "Invalid size #{new_size}" if Size.sizes[new_size].nil?
    @value = new_size
  end

  def <=>(other)
    Size.sizes[self.value] <=> Size.sizes[other.value]
  end

  def to_s
    self.value.to_s
  end

  def to_i
    Size.sizes[self.value].to_i
  end

end