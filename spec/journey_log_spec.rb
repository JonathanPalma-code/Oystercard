require 'journey_log'
require 'journey'

describe Journey_log do

  subject(:journey_log) {described_class.new}
  let(:station) {double :station}
  describe "#start" do
    it "stores a entry station when start method called" do
      journey_log.start(station)
      expect(journey_log.entry_station).to eq(station)
    end
  end
end
