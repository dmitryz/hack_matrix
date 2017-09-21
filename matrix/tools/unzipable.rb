require 'zip'
module Matrix
  module Tools
    module Unzipable
      def unzip(raw, names: [])
        out = ""
        Zip::File.open_buffer(raw) do |zip|
          out = zip.collect do |e|
            next unless e.get_input_stream.is_a?(Zip::InputStream)
            next if names.count > 0 && names.grep(e.name).count.zero?
            e.get_input_stream.read
          end.compact
        end
        out
      end
    end
  end
end
