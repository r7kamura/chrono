require "active_support"
require "active_support/core_ext/numeric/time"

module Chrono
  class NextTime
    attr_reader :now, :source

    attr_writer :time

    def initialize(options)
      @now = options[:now]
      @source = options[:source]
    end

    def to_time
      # the longest cycle is 4 years (leap year)
      # Note that the combination of day-month and wday is OR
      max_time = time + (365 * 3 + 366).days
      while @time < max_time
        case
        when !scheduled_in_this_month?
          carry_month
        when !scheduled_in_this_day?
          carry_day
        when !scheduled_in_this_hour?
          carry_hour
        when !scheduled_in_this_minute?
          carry_minute
        else
          return @time
        end
      end
      raise ArgumentError, "invalid cron string '#{@source}'"
    end

    private

    def time
      @time ||= (now + 1.minute).change(sec: 0)
    end

    def schedule
      @schedule ||= Schedule.new(source)
    end

    def scheduled_in_this_month?
      schedule.months.include?(time.month)
    end

    def scheduled_in_this_day?
      if schedule.last_day_of_month?
        time.day == time.end_of_month.day
      elsif schedule.days?
        if schedule.wdays?
          schedule.days.include?(time.day) || schedule.wdays.include?(time.wday)
        else
          schedule.days.include?(time.day)
        end
      else
        if schedule.wdays?
          schedule.wdays.include?(time.wday)
        else
          true
        end
      end
    end

    def scheduled_in_this_hour?
      schedule.hours.include?(time.hour)
    end

    def scheduled_in_this_minute?
      schedule.minutes.include?(time.min)
    end

    def carry_month
      self.time = time.next_month.at_beginning_of_month
    end

    def carry_day
      self.time = time.tomorrow.at_beginning_of_day
    end

    def carry_hour
      self.time = (time + 1.hour).at_beginning_of_hour
    end

    def carry_minute
      self.time = (time + 1.minute).change(sec: 0)
    end
  end
end
