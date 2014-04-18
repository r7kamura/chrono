module Chrono
  module Fields
    class Hour < Base
      private

      def range
        0..23
      end
    end
  end
end
