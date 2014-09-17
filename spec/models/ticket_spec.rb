require 'spec_helper'

describe Ticket do

  context 'created with locker and slot ID' do

    subject { Ticket.new(0, 1) }

    it { is_expected.to be_valid }

  end

  context 'created from JSON' do

    let(:test_json) do
      { locker_id: 0, slot_id: 1 }.to_json
    end

    subject { Ticket.ticket_from_json(test_json) }

    it { is_expected.to be_valid }

  end

end