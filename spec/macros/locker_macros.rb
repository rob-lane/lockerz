module LockerMacros

  def locker_should_be_greater_than(*sizes)
    sizes.each do |size|
      it "should be greater then #{size}" do
        expect(subject.slot_size).to be > (Locker.new(1, size).slot_size)
      end
    end
  end

  def locker_should_be_less_than(*sizes)
    sizes.each do |size|
      it "should be less than #{size}" do
        expect(subject.slot_size).to be < (Locker.new(1, size).slot_size)
      end
    end
  end

  def locker_should_be_equal_to(size)
    it "should be of equal size to #{size}" do
      expect(subject.slot_size).to eq(Locker.new(1, size).slot_size)
    end
  end

  def it_wont_allow_bag_size(*sizes)
    sizes.each do |size|
      it "wont insert a bag of #{size} size" do
        expect {subject.insert(Bag.new(size)) }.to raise_error
      end
    end
  end

  def it_allows_bag_size(*sizes)
    sizes.each do |size|
      it "inserts a bag of #{size} size" do
        slot_array = subject.instance_variable_get(:@slot_array)
        expect {subject.insert(Bag.new(size))}.to change {slot_array.length}.by(1)
      end
    end
  end

  def it_wont_allow_bags_when_full
    context "inserting bags when the locker is full" do

      before { (1..subject.slots).each  {|i| subject.insert(Bag.new(:small))} }

      it "raises an error" do
        expect {subject.insert(Bag.new(:small))}.to raise_error
      end

    end
  end

end