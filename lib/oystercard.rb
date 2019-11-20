class Oystercard

  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end
  def top_up(amount)
    total = @balance + amount
    raise over_balance_exceed(total) if total > BALANCE_LIMIT
    @balance += amount 
  end

  private

  def over_balance_exceed(total)
    error = "Over balance limit exceed: #{total} / #{BALANCE_LIMIT}."
    BalanceError.new(error)
  end
end

class BalanceError < StandardError
end