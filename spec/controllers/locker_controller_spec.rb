require 'spec_helper'

describe LockerController do

  subject { LockerController.new }

  let(:small_bag) { Bag.new(:small) }

  let(:medium_bag) { Bag.new(:medium) }

  let(:large_bag) { Bag.new(:large) }

  context "created" do

    it "sets the locker count to three" do
      expect(subject.locker_count).to eq(3)
    end

    it "creates the appropriate number of empty lockers" do
      expect(subject.lockers.count).to eq(3)
    end

  end

  context "checking a small bag" do

    it "adds the bag to the small slot locker" do
      expect {
        subject.check_bag(small_bag.to_json)
      }.to change { subject.lockers[0].open_slots }.by(-1)
    end

    context "when the small slot locker is full" do

      before do
        (1..subject.slot_count).each do |_|
          subject.check_bag(small_bag.to_json)
        end
      end

      it "adds the bag to the medium slot locker" do
        expect {
          subject.check_bag(small_bag.to_json)
        }.to change { subject.lockers[1].open_slots }.by(-1)
      end

    end

    context "when the small and medium slot lockers are full" do

      before do
        (1..(subject.slot_count*2)).each do |_|
          subject.check_bag(small_bag.to_json)
        end
      end

      it "adds the bag to the large slot locker" do
        expect {
          subject.check_bag(medium_bag.to_json)
        }.to change { subject.lockers[2].open_slots }.by(-1)
      end

    end

    context "when all lockers are full" do

      before do
        (1..(subject.slot_count*3)).each do |_|
          subject.check_bag(small_bag.to_json)
        end
      end

      it "should raise an error" do
        expect {subject.check_bag(small_bag.to_json)}.to raise_error
      end

    end

  end

  context "checking a medium bag" do

    it "adds a bag to the medium slot locker" do
      expect {
        subject.check_bag(medium_bag.to_json)
      }.to change { subject.lockers[1].open_slots }.by(-1)
    end

    context "when all medium slots are full" do

      before do
        (1..subject.slot_count).each do |_|
          subject.check_bag(medium_bag.to_json)
        end
      end

      it "should add a bag to the large slot locker" do
        expect {
          subject.check_bag(medium_bag.to_json)
        }.to change { subject.lockers[2].open_slots }.by(-1)
      end

    end

    context "when all medium and large slots are full" do

      before do
        (1..subject.slot_count*2).each do |_|
          subject.check_bag(medium_bag.to_json)
        end
      end

      it "should raise an error" do
        expect { subject.check_bag(medium_bag.to_json) }.to raise_error
      end

    end

  end

  context "checking a large bag" do

    it "adds a bag to the large slot locker" do
      expect {
        subject.check_bag(large_bag.to_json)
      }.to change { subject.lockers[2].open_slots }.by(-1)
    end

    context "when all large slots are full" do

      before do
        (1..subject.slot_count).each do |_|
          subject.check_bag(large_bag.to_json)
        end
      end

      it "should raise an error" do
        expect {subject.check_bag(large_bag) }.to raise_error
      end
    end

  end

  context "retrieving a bag" do

    before do
      @ticket = subject.check_bag(small_bag.to_json)
      @original_bag = subject.lockers[0].read_bag_at(0)
    end

    it "should return the bag originally given" do
      expect(subject.retrieve_bag(@ticket.to_json)).to eq(@original_bag)
    end

  end



end