require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new } # give a name for the subject (class) -> card
  subject(:card_with_money) { described_class.new(10)}
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE } # give a name for a constant variable
  let(:fare_price) { Oystercard::FARE_PRICE }
  let(:default_card_balance) {Oystercard::DEFAULT_CARD_BALANCE}
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { {entry_station: entry_station, exit_station: exit_station} }

  describe '#initialize' do
    it 'comes with 0£' do
      expect(card.balance).to eq default_card_balance
    end
  end
  # it 'is not in a journey' do
  #   expect(card.entry_station).to eq nil
  # end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'returns the balance' do # 1st time on top it up
      expect { card.top_up(1) }.to change { card.balance }.by 1
      # card.top_up(2)
      # expect(card.balance).to eq 2
    end

    it 'twice in one go' do
      card.top_up(2)
      card.top_up(3)
      expect(card.balance).to eq 5
    end

    context 'raises error when' do
      specify 'maximum amount exceeded' do
        maximum_exceeded = "#{maximum_balance + 1} / #{maximum_balance}"
        error = "Over balance limit exceed: #{maximum_exceeded}."
        expect { card.top_up maximum_balance+1}.to raise_error BalanceError, error
      end
      it 'exceeds the maximum amount by topping up' do
        maximum_balance.times { card.top_up(1) } # top up 90 times, 1£
        maximum_exceeded = "#{maximum_balance + 50} / #{maximum_balance}"
        error = "Over balance limit exceed: #{maximum_exceeded}."
        expect { card.top_up(50) }.to raise_error BalanceError, error
      end
    end
  end
  describe '#deduct' do
    it 'deducts fare price from its balance' do
      card_with_money.touch_in(entry_station)
      expect{ card_with_money.touch_out(exit_station) }.to change{ card_with_money.balance }.by(-fare_price)
    end
    # context 'raises error when' do
    #   it 'raise error when trying to deduct 0£' do
        
    #   end
    # end
  end
  describe "#touch_in" do
    specify "records the entry station" do
      expect(card_with_money.touch_in(entry_station)).to eq entry_station
    end
    context 'raises error when' do
      specify 'not enough money to deduct' do
        error = "Top up with minimum amount #{fare_price}"
        expect { card.touch_in(entry_station) }.to raise_error BalanceError, error
      end
    end
  end
  describe "#touch_out" do

    it "a fare is charged when touched out" do
      card_with_money.touch_in(entry_station)
      card_with_money.touch_out(exit_station)
      expect{card_with_money.touch_out(exit_station)}.to change{card_with_money.balance}.by(-fare_price)
    end 
    # it "records the journey" do
    #   card_with_money.touch_in(entry_station)
    #   card_with_money.touch_out(exit_station)
    #   record = card_with_money.record_journey(entry_station, exit_station)
    #   expect(record).to eq [journey]
    # end
    # context 'raises error when' do
    #   specify 'touch in recorded unsuccessfully' do
    #     error = "Invalid operation: Card was not touched in."
    #     expect { card_with_money.touch_out(exit_station) }.to raise_error OperationError, error
    #   end
    # end
  end

end
