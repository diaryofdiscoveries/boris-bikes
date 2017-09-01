require 'docking_station'

describe DockingStation do
  subject(:docking_station) {described_class.new}

  it {is_expected.to respond_to :release_bike}

  it 'docks something' do
    bike = Bike.new
    expect(docking_station.dock(bike)).to eq [bike]
  end

  it 'returns docked bikes' do
    bike = Bike.new
    docking_station.dock(bike)
    expect(docking_station.bikes).to eq [bike]
  end

  it 'has a default capacity' do
    expect(subject.capacity).to eq DockingStation::DEFAULT_CAPACITY
  end

  it "raises an error when full" do
    docking_station.capacity.times {docking_station.dock Bike.new}
    expect {docking_station.dock Bike.new}.to raise_error 'Dock is full. Can\'t accept bike.'
  end

  describe '#release_bike' do
    it 'releases a bike' do
      bike = Bike.new
      docking_station.dock(bike)
      expect(docking_station.release_bike).to eq bike
    end

    it 'raises an error when there are no bikes available' do
      expect { docking_station.release_bike}.to raise_error "No bikes available"
    end

    it 'raises an error when bike is broken' do
      bike = Bike.new
      bike.report_broken
      docking_station.dock(bike)
      expect { docking_station.release_bike}.to raise_error "No working bikes"
    end
  end

  describe 'initialization' do
    it 'has a variable capacity' do
      dockingstation = DockingStation.new(50)
      50.times {dockingstation.dock Bike.new}
      expect {dockingstation.dock Bike.new}.to raise_error 'Dock is full. Can\'t accept bike.'
    end
  end

end
