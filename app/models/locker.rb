class Locker < Base
  attr_reader :slot_size
  attr_reader :slots
  validates_presence_of :slots
  validates_presence_of :slot_size

  def initialize(slots, size)
    @slots, @slot_size = slots, Size.new(size)
    @slot_array = []
  end

  def insert(bag)
    raise 'Bag is to big for this locker!' if bag.size > @slot_size
    raise 'This locker is full!' if full?

    @slot_array << bag
    @slot_array.length-1
  end

  def remove_at(slot_index)
    @slot_array.delete_at(slot_index)
  end

  def full?
    @slots <= @slot_array.length
  end

  def open_slots
    @slots - @slot_array.length
  end

  def read_bag_at(idx)
    @slot_array[idx]
  end

end