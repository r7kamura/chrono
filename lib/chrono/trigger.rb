module Chrono
  class Trigger
    attr_reader :block, :source

    def initialize(source, &block)
      @source = source
      @block = block || -> {}
    end

    def once
      wait
      call
    end

    def run
      loop { once }
    end

    private

    def call
      block.call
    end

    def iterator
      @iterator ||= Iterator.new(source)
    end

    def wait
      sleep(period)
    end

    def period
      iterator.next - Time.now + 1.second
    end
  end
end
