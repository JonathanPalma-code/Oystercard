require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new } # give a name for the subject (class) -> card
  let(:maximum_balance) { Oystercard::MAXIMUM_BALANCE } # give a name for a constant variable
  let(:fare_price) { Oystercard::FARE_PRICE }

  it 'returns 0£ when create it' do
    expect(card.balance).to eq 0
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

    context 'raises an error when' do
      specify 'not enough money to deduct' do
        expect { card.deduct }.to raise_error "Top up with minimum amount #{fare_price}"
      end
    end
  end
end
