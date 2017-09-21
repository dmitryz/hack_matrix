require 'json'
module Matrix
  module Intruders
    class Loopholes < Base
      def file_names
        %w{loopholes/routes.json loopholes/node_pairs.json}
      end

      def parse(data)
        @data = data.collect do |content|
          JSON.parse(content, headers: true, col_sep: ', ')
        end.reduce({}, :merge)
      end

      def routes
        @data['routes'].map do |route|
          node = find_node(route['node_pair_id'])
          next unless node
          { start_node: node['start_node'],
            end_node: node['end_node'],
            start_time: parse_time(route['start_time']),
            end_time: parse_time(route['end_time']) }
        end.compact
      end

      private

      def find_node(id)
        @data['node_pairs'].select { |np| np['id'] == id }.first
      end
    end
  end
end
