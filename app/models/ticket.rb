class Ticket < Base
  attr_reader :locker_id, :slot_id

  def self.ticket_from_json(ticket_json)
    ticket_obj = JSON.parse(ticket_json)
    Ticket.new(ticket_obj['locker_id'], ticket_obj['slot_id'])
  end

  def initialize(locker_id, slot_id)
    @locker_id, @slot_id = locker_id, slot_id
  end

  def to_json
    {locker_id: locker_id, slot_id: slot_id}.to_json
  end
end