module Sizeable
  include Comparable
  attr_reader :size

  def sizes
    { small: 0,
      medium: 1,
      large: 2 }
  end

  def <=>(other)
    self.size <=> other.size
  end

  def size=(new_size)
    raise "Invalid size #{new_size}" if self.sizes[new_size].nil?
    @size = self.sizes[new_size]
  end

end