require_relative 'bike'

class DockingStation
attr_reader :bikes
attr_reader :capacity
DEFAULT_CAPACITY = 20

  def initialize(num = DEFAULT_CAPACITY)
    @bikes = []
    @capacity = num
  end

  def release_bike
    fail 'No bikes available' if empty?
    bikes.pop
  end

  def dock(bike)
    fail 'Dock is full. Can\'t accept bike.' if full?
    bikes << bike
  end

private

  def full?
    bikes.length >= capacity
  end

  def empty?
    bikes.empty?
  end

end
