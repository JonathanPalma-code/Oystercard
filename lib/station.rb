class Station
  attr_reader :name, :zone

  def initialize(name , zone)
    # raise station_incomplete if name == nil || zone == nil
    @name = name
    @zone = zone
  end
end

# private

# def station_incomplete
#   error = "Enter a station and zone."
#   StationError.new(error)
# end

# class StationError < ArgumentError
# end