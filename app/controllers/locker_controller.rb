class LockerController
  attr_reader :lockers
  attr_reader :locker_count
  attr_reader :slot_count

  def initialize
    @lockers, @locker_count, @slot_count = [], Size.sizes.length, 100
    Size.sizes.each do |size, idx|
      @lockers[idx] = Locker.new(@slot_count, size)
    end
  end

  def check_bag(bag_json)
    insert_bag(Bag.bag_from_json(bag_json))
  end

  def retrieve_bag(ticket_json)
    remove_bag(Ticket.ticket_from_json(ticket_json))
  end

  private
    def insert_bag(bag)
      raise "Invalid Bag!" if bag.invalid?
      @lockers.each_with_index do |locker, idx|
        next if bag.size > locker.slot_size
        next if locker.full?
        return Ticket.new(idx, locker.insert(bag))
      end

      raise "No room for bag of size #{bag.size}"
    end

    def remove_bag(new_ticket)
      @lockers[new_ticket.locker_id].remove_at(new_ticket.slot_id)
    end

end