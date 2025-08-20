=begin
Without running the faulty code, I believe line 39 outputs false because both
ada.location and grace.location return a GeoLocation object, and calling == is
comparing whether they are the same object, not whether these two GeoLocation
objects contain the same states.

Calling new on GeoLocation always returns a new object, regardless of whether
the same values for latitude and longitude are passed in as arguments.
=end

# My fix:
class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(new_location)
    @location = new_location
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(grace.location)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # true
