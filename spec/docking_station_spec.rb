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

  it "doesn't accept more bikes than capacity" do
    DockingStation::DEFAULT_CAPACITY.times do
      docking_station.dock Bike.new
    end
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
  end

end
