class Oystercard

  # 90 of balance limit
  MAXIMUM_BALANCE = 90
  # 1£ of fare
  FARE_PRICE = 1
  DEFAULT_CARD_BALANCE = 0
  attr_reader :balance, :entry_station, :journey_story, :exit_station

  def initialize(balance = DEFAULT_CARD_BALANCE)
    @balance = balance
    @journey_story = []
    @journey_log = Journey_log.new
    @journey = Journey.new
    # @entry_station
  end

  def top_up(amount)
    total = @balance + amount
    raise over_balance_exceed(total) if total > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    total = @balance - FARE_PRICE
    raise not_enough_funds if total < FARE_PRICE
    @journey_log.start(entry_station)
  end

  def touch_out(exit_station)
    # raise no_touched_in if @entry_station == nil
    @journey_log.end(exit_station)
    deduct
  end

  def record_journey(entry_station, exit_station)
    @journey_story << {entry_station: @entry_station, exit_station: @exit_station}
  end

  private

  def deduct
    @balance -= @journey.fare
  end

  def over_balance_exceed(total)
    error = "Over balance limit exceed: #{total} / #{MAXIMUM_BALANCE}."
    BalanceError.new(error)
  end

  def not_enough_funds
    error = "Top up with minimum amount #{FARE_PRICE}"
    BalanceError.new(error)
  end

  def no_touched_in
    error = "Invalid operation: Card was not touched in."
    OperationError.new(error)
  end

end

class BalanceError < StandardError
end

class OperationError < StandardError
end
