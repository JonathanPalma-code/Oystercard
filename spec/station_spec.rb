require 'station'

describe Station do
  subject(:station) { described_class.new("Aldgate", 1) }
  subject(:station_incomplete) { described_class.new }

  it "returns zone number" do
    expect(station.zone).to eq 1
  end
  it "returns name station" do
    expect(station.name).to eq "Aldgate"
  end
  # it { expect{ station_incomplete }.to raise_error ArgumentError }
end