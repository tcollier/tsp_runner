module TspRunner
  class Location
    RADIANS_PER_DEGREE = Math::PI / 180
    EARTH_RADIUS       = 6371 * 1000  # in meters

    attr_reader :name, :lat, :lon

    # @param name [String] the name of the location
    # @param lat [Fixnum] the latitude
    # @param lon [Fixnum] the longitude
    def initialize(name, lat, lon)
      unless lat.in?(-90..90)
        raise ArgumentError, 'Latitudue should be between -90 and 90'
      end

      unless lon.in?(-180..180)
        raise ArgumentError, 'Longitudue should be between -180 and 180'
      end

      @name, @lat, @lon = name, lat, lon
    end

    # @return [Fixnum] the latitude in radians
    def lat_rad
      lat * RADIANS_PER_DEGREE
    end

    # @return [Fixnum] the longitude in radians
    def lon_rad
      lon * RADIANS_PER_DEGREE
    end

    # Gleefully stolen from:
    # http://stackoverflow.com/questions/12966638/how-to-calculate-the-distance-between-two-gps-coordinates-without-using-google-m
    #
    # @return [Fixnum] the haversine distance of the location (from self) as
    #   measured in meters
    def distance_from(location)
      delta_lat = location.lat_rad - lat_rad
      delta_lon = location.lon_rad - lon_rad

      a = Math.sin(delta_lat / 2) ** 2 + Math.cos(lat_rad) *
          Math.cos(location.lat_rad) * Math.sin(delta_lon / 2) ** 2
      c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1 - a))

      EARTH_RADIUS * c
    end
  end
end