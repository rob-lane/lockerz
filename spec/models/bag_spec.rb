require 'spec_helper'

describe Bag do

  let (:small_bag) { Bag.new(:small) }
  let (:medium_bag) { Bag.new(:medium) }
  let (:large_bag) { Bag.new(:large) }

  context 'created with a small size' do

    subject { Bag.new(:small) }

    it { is_expected.to be_valid }

  end

  context 'created with a medium size' do

    subject { Bag.new(:medium) }

    it { is_expected.to be_valid }

  end

  context 'created with a large size' do

    subject { Bag.new(:large) }

    it { is_expected.to be_valid }

  end

  context 'created with an invalid size' do

    it "should raise an error" do
      expect { Bag.new(0) }.to raise_error
    end

  end

  context 'created without a size' do

    it "should raise an error"do
      expect { Bag.new(nil) }.to raise_error
    end

  end

  context "of a large size" do

    subject { Bag.new(:large) }

    it "is larger than a medium bag" do
      expect(subject.size).to be > medium_bag.size
    end

    it "is larger than a small bag" do
      expect(subject.size).to be > small_bag.size
    end

    it "is of equal size to another large bag" do
      expect(subject.size).to eq(large_bag.size)
    end

  end

  context "of a medium size" do

    subject { Bag.new(:medium) }

    it "is larger than a small bag" do
      expect(subject.size).to be > small_bag.size
    end

    it "is of equal size to another medium bag" do
      expect(subject.size).to eq(medium_bag.size)
    end

    it "is smaller than a large bag" do
      expect(subject.size).to be < large_bag.size
    end

  end

  context "of a small size" do

    subject { Bag.new(:small) }

    it "is of equal size to another small bag" do
      expect(subject.size).to eq(small_bag.size)
    end

    it "is smaller than a medium bag" do
      expect(subject.size).to be < medium_bag.size
    end

    it "is smaller than a large bag" do
      expect(subject.size).to be < large_bag.size
    end

  end

  context 'created with json' do

    let(:test_json) do
      { size: :small }.to_json
    end

    subject { Bag.bag_from_json(test_json) }

    it { is_expected.to be_valid }

  end

end