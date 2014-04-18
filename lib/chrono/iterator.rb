module Chrono
  class Iterator
    attr_accessor :now

    attr_reader :source

    def initialize(source, options = {})
      @source = source
      @now = options[:now] || Time.now
    end

    def next
      self.now = NextTime.new(now: now, source: source).to_time
    end
  end
end
