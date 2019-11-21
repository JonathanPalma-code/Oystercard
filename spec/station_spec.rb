require 'station'

describe Station do
  subject(:station) { described_class.new("Aldgate", 1) }

  it "returns zone station" do
    expect(station.zone).to eq 1
  end
  it "returns zone station" do
    expect(station.name).to eq "Aldgate"
  end

end