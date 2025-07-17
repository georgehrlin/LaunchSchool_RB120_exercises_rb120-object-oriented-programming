class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels
    self.class::NUM_OF_WHEELS
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  NUM_OF_WHEELS = 4
end

class Motorcycle < Vehicle
  NUM_OF_WHEELS = 2
end

class Truck < Vehicle
  NUM_OF_WHEELS = 6

  attr_reader :payload

  def initailize(make, model, payload)
    super(make, model)
    @payload = payload
  end
end