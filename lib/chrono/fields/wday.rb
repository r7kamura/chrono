module Chrono
  module Fields
    class Wday < Base
      TABLE = {
        '7'   => '0',
        'sun' => '0',
        'mon' => '1',
        'tue' => '2',
        'wed' => '3',
        'thu' => '4',
        'fri' => '5',
        'sat' => '6',
      }
      REGEXP = %r<\A(?:(?<step>(?:\*|(?:(?<atom>\d+|sun|mon|tue|wed|thu|fri|sat)(?:-\g<atom>)?))(?:/\d+)?)(?:,\g<step>)*)\z>ix

      def initialize(source)
        unless REGEXP =~ source
          raise InvalidField.new('Unparsable field', source)
        end
        @source = source
      end

      private

      def interpolated
        super.downcase.gsub(/7|sun|mon|tue|wed|thu|fri|sat/, TABLE)
      end

      def range
        0..6
      end
    end
  end
end
