require_relative '../lib/station.rb'

describe Station do
  describe '#name' do
    it "should test its own name" do
    expect(subject.name).to eq ("name")
    end
  end

  describe '#zone' do
  it "should return the name of the zone" do
  expect(subject.zone).to eq ("zone")
  end
end
end 