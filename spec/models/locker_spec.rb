require 'spec_helper'

describe Locker do

  let!(:test_slots) { 10 }

  context 'created with a small size' do

    subject { Locker.new(test_slots, :small)  }

    it { is_expected.to be_valid }

    locker_should_be_equal_to :small

    locker_should_be_less_than :medium, :large

    it_allows_bag_size :small

    it_wont_allow_bag_size :medium, :large

    it_wont_allow_bags_when_full

  end

  context 'created with a medium size' do

    subject { Locker.new(test_slots, :medium) }

    it { is_expected.to be_valid }

    locker_should_be_greater_than :small

    locker_should_be_equal_to :medium

    locker_should_be_less_than :large

    it_allows_bag_size(:small, :medium)

    it_wont_allow_bag_size(:large)

    it_wont_allow_bags_when_full

  end

  context 'created with a large size' do

    subject { Locker.new(test_slots, :large) }

    it { is_expected.to be_valid }

    locker_should_be_greater_than :small, :medium

    locker_should_be_equal_to :large

    it_allows_bag_size(:small, :medium, :large)

    it_wont_allow_bags_when_full

  end

  context 'created with an invalid size' do

    it "should raise an error" do
      expect { Locker.new(test_slots, :huge) }.to raise_error
    end

  end

end