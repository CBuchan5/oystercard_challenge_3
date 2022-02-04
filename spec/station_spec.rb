require_relative '../lib/station.rb'

describe Station do

  subject {described_class.new('Old Street', 1)}

    it "should test its own name" do
      expect(subject.name).to eq('Old Street')
    end
  

    it "should return the name of the zone" do
      expect(subject.zone).to eq(1)
    end
 
end 