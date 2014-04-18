module Chrono
  class Iterator
    attr_reader :source

    def initialize(source)
      @source = source
    end

    # TODO
    def next
      Time.now
    end

    private

    def expression
      @expression ||= Expression.new(source)
    end
  end
end
