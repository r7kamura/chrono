module Chrono
  module Fields
    class Minute < Base
      private

      def range
        0..59
      end
    end
  end
end
