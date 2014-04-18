module Chrono
  class NextTime
    attr_reader :source

    def initialize(source)
      @source = source
    end

    # TODO
    def to_time
      Time.now
    end
  end
end
