class Bag < Base
  attr_reader :size

  validates_presence_of :size

  def self.bag_from_json(bag_json)
    bag_obj = JSON.parse(bag_json)
    Bag.new(bag_obj['size'].to_sym)
  end

  def initialize(size)
    @size = Size.new(size)
  end

  def to_json
    {size: size}.to_json
  end
end