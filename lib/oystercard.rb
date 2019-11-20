class Oystercard

  # 90 of balance limit
  MAXIMUM_BALANCE = 90
  # 2£ of fare
  FARE_PRICE = 2
  DEFAULT_BALANCE = 0
  attr_reader :balance, :station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    total = @balance + amount
    raise over_balance_exceed(total) if total > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct
    @balance -= FARE_PRICE
  end

  def touch_in(station)
    total = @balance - FARE_PRICE
    raise not_enough_funds if total < FARE_PRICE
    balance > FARE_PRICE ? @station = station : nil
  end

  def touch_out
    deduct
    station = nil
  end

  private

  def over_balance_exceed(total)
    error = "Over balance limit exceed: #{total} / #{MAXIMUM_BALANCE}."
    BalanceError.new(error)
  end

  def not_enough_funds
    error = "Top up with minimum amount #{FARE_PRICE}"
    BalanceError.new(error)
  end

end

class BalanceError < StandardError
end
