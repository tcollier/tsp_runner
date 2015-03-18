require 'timeout'

module TspRunner
  class Runner
    class BaseError < StandardError; end
    class TimeoutError < BaseError; end
    class InvalidError < BaseError; end

    attr_reader :cmd, :input_filename, :output

    def initialize(cmd, input_filename)
      @cmd, @input_filename  = cmd, input_filename
    end

    def run(time_limit)
      @output = Timeout.timeout(time_limit) { `#{cmd} #{input_filename}` }
    rescue Timeout::Error
      raise TimeoutError, 'Failed: timeout'
    end

    def validate!(initial_location_name = nil)
      solution = TspRunner::Solution.from_string(output, location_hash)
      if solution.valid?(initial_location_name)
        solution.total_distance / 1000.0
      else
        raise InvalidError, ['Failed: invalid', output].join("\n")
      end
    end

    private

    def location_hash
      @location_hash ||= TspRunner::LocationHash.from_file(input_filename)
    end
  end
end
