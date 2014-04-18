module Chrono
  module Fields
    class Day < Base
      private

      def range
        1..31
      end
    end
  end
end
