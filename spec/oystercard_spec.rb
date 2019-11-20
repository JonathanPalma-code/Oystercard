require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new } # give a name for the subject (class) -> card
  subject(:card_with_money) { described_class.new(10)}
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE } # give a name for a constant variable
  let(:fare_price) { Oystercard::FARE_PRICE }
  let(:default_balance) {Oystercard::DEFAULT_BALANCE}
  let(:station) { double :station }

  it 'returns 0£ when create it' do
    expect(card.balance).to eq default_balance
  end
  it 'is not in a journey' do
    expect(card.station).to eq nil
  end

  describe '#top up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'returns the balance' do # 1st time on top it up
      expect { card.top_up(1) }.to change { card.balance }.by 1
      # card.top_up(2)
      # expect(card.balance).to eq 2
    end

    it 'tops up twice' do
      card.top_up(2)
      card.top_up(3)
      expect(card.balance).to eq 5
    end

    context 'raises an error when' do
      it 'exceeds the maximum amount' do
        error = "Over balance limit exceed: #{maximum_balance + 1} / #{maximum_balance}."
        expect { card.top_up maximum_balance+1}.to raise_error BalanceError, error
      end
      it 'exceeds the maximum amount by topping up' do
        maximum_balance.times { card.top_up(1) } # top up 90 times, 1£
        error = "Over balance limit exceed: #{maximum_balance + 50} / #{maximum_balance}."
        expect { card.top_up(50) }.to raise_error BalanceError, error
      end
    end
  end
  describe '#deduct' do
    it 'deducts fare price from its balance' do
      card.top_up(5)
      card.deduct
      expect(card.balance).to eq 3
    end
  end

  describe "#touch_in" do
    # it "Approves that passenger is in journey" do
    #   card.top_up(89)
    #   expect(card.touch_in(:station)).to eq(true)
    # end

    context 'raises an error when' do
      specify 'not enough money to deduct' do
        error = "Top up with minimum amount #{fare_price}"
        expect { card.touch_in(station) }.to raise_error BalanceError, error
      end
    end
    it "records an entry station." do
      expect(card_with_money.touch_in(station)).to eq station 
    end
  end

  describe "#touch_out" do
    it "Confirms that passenger is no longer in journey" do
      expect(card_with_money.touch_out).to eq nil
    end
  end
  describe "#in_journey" do
    it "confirms if passenger is NOT journey" do
      card_with_money.touch_in(station)
      expect(card_with_money.touch_out).to eq nil
    end
  end
end
