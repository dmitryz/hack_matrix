require 'csv'
module Matrix
  module Intruders
    class Sniffers < Base
      def file_names
        ["sniffers/routes.csv", "sniffers/node_times.csv", "sniffers/sequences.csv"]
      end

      def parse(data)
        @data = data.collect { |content| CSV.parse(content, headers: true, col_sep: ', ') }
      end

      def routes
        @data[2].map { |seq| build_routes(seq) }.flatten.compact
      end

      private

      def build_routes(seq)
        route = find_routes_by_id(seq['route_id'])
        node_time = find_node_time_by_id(seq['node_time_id'])
        build_route(route, node_time) if route && node_time
      end

      def find_routes_by_id(id)
        @data[1].select { |route| route['route_id'] == id }.first
      end

      def find_node_time_by_id(id)
        @data[0].select { |node_time| node_time['node_time_id'] == id }.first
      end

      def build_route(route, node_time)
        start_time = Time.parse(route['time'] + route['time_zone'])
        { start_node:  node_time['start_node'],
          end_node: node_time['end_node'],
          start_time: parse_time(start_time.to_s),
          end_time: parse_time((start_time + (node_time['duration_in_milliseconds'].to_i / 1000)).to_s) }
      end
    end
  end
end
