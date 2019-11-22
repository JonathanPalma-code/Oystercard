

class Journey_log
  attr_reader :entry_station, :exit_station, :journey_story
  def initialize(journey = Journey.new, entry_station = nil, exit_station = nil)
    @journey = journey
    @journey_story = []
    @entry_station = entry_station
    @exit_station = exit_station
    @current_journey = []
  end

  def start(station)
    @journey.start(station)
    @entry_station = station
    current_journey(station)
  end

  def end(station)
    @journey.finish(station)
    @exit_station = station
    current_journey(station)
  end

  def current_journey(station = nil)
    # @current_journey<< @entry_station
    # @journey_story << {entry_station: @entry_station, exit_station: @exit_station } if station == true
    # @entry_station = nil if @exit_station == true
    # @exit_station == nil ? @current_journey : @current_journey = []
  end
end
