module TspRunner
  class Solution
    attr_reader :location_hash, :location_names

    def self.from_file(filename, location_hash)
      new(location_hash).tap do |solution|
        File.open(filename).each do |line|
          solution << line.chomp
        end
      end
    end

    def self.from_string(str, location_hash)
      new(location_hash).tap do |solution|
        str.split("\n").each do |line|
          solution << line.chomp
        end
      end
    end

    def initialize(location_hash)
      @location_hash = location_hash
      @location_names = []
    end

    def <<(location_name)
      location_names << location_name
    end

    def valid?(initial_location_name = nil)
      if initial_location_name
        return false if initial_location_name != location_names.first
      end
      location_hash.location_names.sort == location_names.sort
    end

    def total_distance
      distance = 0
      location_names.each.with_index do |location_name, index|
        location = location_hash[location_name]
        next_index = (index + 1) % location_names.length
        next_location_name = location_names[next_index]
        next_location = location_hash[next_location_name]
        distance += location.distance_from(next_location)
      end
      distance
    end
  end
end
