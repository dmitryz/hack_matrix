require 'net/http'
module Matrix
  module Tools
    module Uploadable
      def upload(url, params={})
        uri = URI.parse(url)
        resp = Net::HTTP.post_form(uri, params)
        resp
      end
    end
  end
end
