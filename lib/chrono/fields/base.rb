module Chrono
  module Fields
    class Base
      attr_reader :source

      def initialize(source)
        @source = source
      end

      def to_a
        lower.step(upper, step).to_a
      end

      private

      def range
        raise NotImplementedError
      end

      def interpolated
        source.gsub("*", "#{range.first}-#{range.last}")
      end

      def lower
        @lower ||= match_data[1].to_i
      end

      def upper
        if match_data[2]
          match_data[2].to_i
        else
          lower
        end
      end

      def step
        if match_data[3]
          match_data[3].to_i
        else
          1
        end
      end

      def pattern
        %r<\A(\d+)(?:-(\d+))?(?:/(\d+))?\z>
      end

      def match_data
        @match_data ||= interpolated.match(pattern)
      end
    end
  end
end
