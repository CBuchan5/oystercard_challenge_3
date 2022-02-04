require_relative '../lib/oystercard'

describe Oystercard do
  it { is_expected.to respond_to(:top_up).with(1).argument }

  # excluding the "deduct" tests because deduct is now a private method.  
  # it { is_expected.to respond_to(:deduct) }

  it { is_expected.to respond_to(:in_journey?) }

  it { is_expected.to respond_to(:touch_in) }

  it { is_expected.to respond_to(:touch_out) }

  # describe "#entry_station" do
  let(:entry_station){ double :entry_station}
  let(:exit_station){ double :exit_station}

  # it 'stores the entry station' do
  #   subject.top_up(50)
  #   subject.touch_in(:entry_station)
  #   expect(subject.entry_station).to eq :entry_station
  #   end 
  # end


  it "has a balance of 0 upon initialization" do
    expect(subject.balance).to eq 0
  end

  it "is initially not in a journey" do
    expect(subject).not_to be_in_journey
  end

  describe "#top_up" do

    it "tops up the balance with the argument balance provided" do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it "should fail if balance is more than £90" do
      limit = Oystercard::LIMIT
      subject.top_up(limit)
      expect { subject.top_up(1)}.to raise_error "£#{limit} limit exceeded"
    end
  end

  # excluding the "deduct" tests because deduct is now a private method.
  # describe "#deduct" do
  #
  #   it "deducts the balance by value amount" do
  #     subject.top_up(25)
  #     expect{ subject.deduct(10) }.to change{ subject.balance }.by -10
  #   end
  # end

  describe "#touch_in" do

    it "shouldn't let you touch in if balance is less than £1" do
    #  minimum_balance = Oystercard::MINIMUM
      expect{ subject.touch_in(:entry_station) }.to raise_error "Not enough balance"
    end

    it "returns station if the card has been touched in" do
      subject.top_up(20)
      subject.touch_in(:entry_station)
      expect(subject.current_journey).to eq ({ :entry_station => :entry_station})
    end

    it "has an empty list of journeys by default" do
      expect(subject.journeys).to be_empty
    end

    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }
    it "stores a journey" do
      subject.top_up(25)
      subject.touch_in(entry_station) 
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
  end

  describe "#touch_out" do

    it "Set entry_station to nil if the card has been touched out" do
      subject.touch_out(:exit_station) 
      expect(subject.current_journey).to eq {}
      # expect(subject.touch_out(exit_station)).to eq nil
    end

    it "deducts minimum fare upon touching out" do
      minimum = Oystercard::MINIMUM
      subject.top_up(25)
      subject.touch_in(:entry_station)
      expect { subject.touch_out(:exit_station) }.to change { subject.balance }.by -minimum
    end

    it "should record the exit station upon touch_out" do
      # minimum = Oystercard::MINIMUM
      subject.top_up(25)
      subject.touch_in(:entry_station)
      # subject.entry_station
      # subject.touch_out(:exit_station)
      # subject.deduct(1)
      expect(subject.touch_out(:exit_station)).to eq :exit_station
    end

    # it "shuould record a list of exit stations upon touch_out" do
    # end


  end

  
end
