class Oystercard

  # 90 of balance limit
  MAXIMUM_BALANCE = 90
  # 2£ of fare
  FARE_PRICE = 2
  DEFAULT_BALANCE = 0
  attr_reader :balance, :entry_station, :journey_story, :exit_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_story = []
    @entry_station
  end

  def top_up(amount)
    total = @balance + amount
    raise over_balance_exceed(total) if total > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct
    @balance -= FARE_PRICE
  end

  def touch_in(entry_station)
    total = @balance - FARE_PRICE
    raise not_enough_funds if total < FARE_PRICE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct
    @exit_station = exit_station
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
