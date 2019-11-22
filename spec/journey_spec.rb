require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:station) { double(:station) }
  let(:penalty_fare_price) { Journey::PENALTY_FARE_PRICE }
  let(:fare_price) { Journey::FARE_PRICE }

  specify 'a penalty fare by default' do
    expect(journey.fare).to eq penalty_fare_price
  end

  describe '#start' do
    it 'enters a entry station and saves it' do
      journey.start("Liverpool Street")
      expect(journey.entry_station).to eq("Liverpool Street")
    end
  end
  describe '#finish' do
    it 'enters a exit station and saves it' do
      journey.finish(station)
      expect(journey.exit_station).to eq(station)
    end
  end
  describe '#fare' do
    it 'returns fare if the journey is complete' do
      allow(journey).to receive(:entry_station) {"Liverpool Street"}
      allow(journey).to receive(:exit_station) {station}
      expect(journey.fare).to eq(fare_price)
    end
    it 'returns penalty fare if there is not entry station but exit station' do
      allow(journey).to receive(:exit_station) {station}
      expect(journey.fare).to eq(penalty_fare_price)
    end
    it 'returns penalty fare if there is not exit station but entry station' do
      allow(journey).to receive(:entry_station) {station}
      expect(journey.fare).to eq(penalty_fare_price)
    end
  end
  describe '#complete' do
    it 'return if journey is complete' do
      allow(journey).to receive(:entry_station) {"Liverpool Street"}
      allow(journey).to receive(:exit_station) {station}
      expect(journey.complete?).to eq(true)
    end
    it 'return it journey is NOT complete' do
      allow(journey).to receive(:entry_station) {station}
      expect(journey.complete?).to eq(false)
    end
  end
end