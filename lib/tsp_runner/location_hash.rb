module TspRunner
  class LocationHash
    attr_reader :locations

    def self.from_file(filename)
      new.tap do |location_hash|
        File.open(filename).each do |line|
          name, lat_str, lon_str = *line.chomp.split(',')
          location_hash << Location.new(name, Float(lat_str), Float(lon_str))
        end
      end
    end

    def initialize
      @locations = {}
    end

    def <<(location)
      locations[location.name] = location
    end

    def [](location_name)
      locations[location_name]
    end

    def location_names
      locations.keys
    end
  end
end
