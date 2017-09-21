require 'net/http'
module Matrix
  module Tools
    module Downloadable
      def download(url, params={})
        uri = URI.parse(url)
        uri.query = URI.encode_www_form(params)
        Net::HTTP.get(uri)
      end
    end
  end
end
