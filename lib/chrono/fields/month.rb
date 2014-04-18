module Chrono
  module Fields
    class Month < Base
      private

      def range
        1..12
      end
    end
  end
end
