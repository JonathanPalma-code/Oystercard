class Journey

  attr_reader :entry_station, :exit_station

  PENALTY_FARE_PRICE = 6
  FARE_PRICE = 1

  def initialize
    @penalty_fare_price = PENALTY_FARE_PRICE
    @entry_station
    @exit_station
  end
  
  def fare #calling attr_reader method
    entry_station && exit_station ? FARE_PRICE : PENALTY_FARE_PRICE
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def complete?
    entry_station && exit_station ? true : false
  end
end