module Chrono
  class Schedule
    attr_reader :source

    def initialize(source)
      @source = source
    end

    def minutes
      Fields::Minute.new(fields[0]).to_a
    end

    def hours
      Fields::Hour.new(fields[1]).to_a
    end

    def days
      Fields::Day.new(fields[2]).to_a
    end

    def months
      Fields::Month.new(fields[3]).to_a
    end

    def wdays
      Fields::Wday.new(fields[4]).to_a
    end

    private

    def fields
      @fields ||= source.split(" ")
    end
  end
end
