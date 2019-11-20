require 'oystercard'

describe Oystercard do

  subject(:card) { described_class.new } # give a name for the subject (class) -> card
  let(:balance_limit) { Oystercard::BALANCE_LIMIT } # give a name for a constant variable

  it 'return 0£ when create it' do
    expect(card.balance).to eq 0
  end

  describe '#top up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'should return the balance' do # 1st time on top it up
      expect { card.top_up(1) }.to change { card.balance }.by 1 
    end

    it 'should top up twice' do
      card.top_up(2)
      card.top_up(3)
      expect(card.balance).to eq 5
    end

    context 'Raise an error when' do
      it 'exceed the maximum amount' do
        expect { card.top_up balance_limit+1}.to raise_error BalanceError, "Over balance limit exceed: #{balance_limit + 1} / #{balance_limit}."
      end
    end
  end
end