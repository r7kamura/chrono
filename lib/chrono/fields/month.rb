module Chrono
  module Fields
    class Month < Base
      TABLE = {
        'jan' => '1',
        'feb' => '2',
        'mar' => '3',
        'apr' => '4',
        'may' => '5',
        'jun' => '6',
        'jul' => '7',
        'aug' => '8',
        'sep' => '9',
        'oct' => '10',
        'nov' => '11',
        'dec' => '12',
      }
      REGEXP = %r<\A(?<step>(?:\*|(?:(?<atom>\d+||jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)(?:-\g<atom>)?))(?:/\d+)?)(?:,\g<step>)*\z>ix

      def initialize(source)
        unless REGEXP =~ source
          raise InvalidField.new('Unparsable field', source)
        end
        @source = source
      end

      private

      def interpolated
        super.downcase.gsub(/jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec/, TABLE)
      end

      def range
        1..12
      end
    end
  end
end
