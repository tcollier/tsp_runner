require 'timeout'

module TspRunner
  class Runner
    class InvalidError < StandardError; end

    attr_reader :cmd, :filename, :time_limit

    def self.usage
      puts "Usage: #{$0} <time limit> <input file> <command> [command arg 1]..."
      puts ''
      puts ' time limit    - maximum duration the executable can run in seconds'
      puts ' input file    - input file with location names and lat/lons'
      puts ' command       - command line executable that calculates the path'
      puts ' command arg n - optional args for the command line executable'
    end

    def initialize(time_limit, filename, *cmd_and_opts)
      @time_limit = time_limit
      @filename = filename
      @cmd = cmd_and_opts.join(' ')
    end

    def validate_input
      return false if time_limit.nil? || filename.nil? || cmd.to_s.length == 0
      Integer(time_limit.to_s, 10)
      unless File.exists?(filename.to_s)
        puts "Input file does not exist: #{filename}"
        return false
      end
      true
    rescue ArgumentError
      puts "Invalid time limit: #{time_limit}"
      false
    end

    def run
      unless validate_input
        self.class.usage
        return
      end

      output = Timeout.timeout(time_limit.to_i) { `#{cmd} #{filename}` }
      distance = validate!(output, 'San Francisco')
      puts("Success: #{distance} km")
    rescue InvalidError => error
      $stderr.puts error
      exit(1)
    rescue Timeout::Error
      $stderr.puts 'Failed: timeout'
      exit(1)
    end

    def validate!(output, initial_location_name = nil)
      solution = TspRunner::Solution.from_string(output, location_hash)
      if solution.valid?(initial_location_name)
        solution.total_distance / 1000.0
      else
        raise InvalidError, ['Failed: invalid, program output:', output].join("\n")
      end
    end

    private

    def location_hash
      @location_hash ||= TspRunner::LocationHash.from_file(filename)
    end
  end
end
