require 'csv'
module Matrix
  module Intruders
    class Sentinels < Base
      def file_names
        ["sentinels/routes.csv"]
      end

      def parse(data)
        @data = CSV.parse(data.first, headers: true, col_sep: ', ')
      end

      def routes
        routes_ids.map { |route_id| build_routes(route_id) }.flatten
      end

      private

      def build_routes(route_id)
        my_routes = find_routes_by_id(route_id)
        my_routes.reduce([]) do |a,v|
          a << build_route(my_routes, v)
        end.compact
      end

      def build_route(routes, route1)
        route2 = next_route(routes, route1)
        return nil unless route2
        { start_node: route1['node'],
          end_node: route2['node'],
          start_time: parse_time(route1['time']),
          end_time: parse_time(route2['time']) }
      end

      def next_route(routes, route)
        routes.select { |r| r['index'] > route['index'] }.first
      end

      def find_routes_by_id(route_id)
        @data.select { |d| d['route_id'] == route_id }.sort_by { |d| d['index'] }
      end

      def routes_ids
        @data.map { |d| d['route_id'] }.uniq.sort
      end
    end
  end
end
