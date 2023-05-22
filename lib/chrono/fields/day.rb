module Chrono
  module Fields
    class Day < Base
      private

      def range
        1..31
      end

      def wildcards
        ['L']
      end
    end
  end
end
