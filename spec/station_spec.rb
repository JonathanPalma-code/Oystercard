require 'station'

describe Station do
  subject(:station) { described_class.new("Aldgate", 1) }

  it "returns zone number" do
    expect(station.zone).to eq 1
  end
  it "returns name station" do
    expect(station.name).to eq "Aldgate"
  end

end