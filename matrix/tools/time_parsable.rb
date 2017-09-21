require 'time'
module Matrix
  module Tools
    module TimeParsable
      def parse_time(dt)
        Time.parse(dt).utc.iso8601.delete('Z')
      end
    end
  end
end
