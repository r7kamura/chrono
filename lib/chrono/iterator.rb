module Chrono
  class Iterator
    attr_reader :source

    def initialize(source)
      @source = source
    end

    def next
      NextTime.new(source).to_time
    end
  end
end
