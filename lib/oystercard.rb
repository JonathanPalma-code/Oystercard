class Oystercard

  # 90 of balance limit
  MAXIMUM_BALANCE = 90
  # 2£ of fare
  FARE_PRICE = 2
  attr_reader :balance

  def initialize
    @balance = 0
  end
  def top_up(amount)
    total = @balance + amount
    raise over_balance_exceed(total) if total > MAXIMUM_BALANCE
    @balance += amount
  end
  def deduct
    total = @balance - FARE_PRICE
    error = "Top up with minimum amount #{FARE_PRICE}"
    raise error if total < FARE_PRICE
    @balance -= FARE_PRICE
  end

  private

  def over_balance_exceed(total)
    error = "Over balance limit exceed: #{total} / #{MAXIMUM_BALANCE}."
    BalanceError.new(error)
  end
end

class BalanceError < StandardError
end
