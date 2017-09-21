require 'time'
module Matrix
  module Intruders
    class Base
      attr_accessor :answers

      include Matrix::Config
      include Matrix::Tools::Downloadable
      include Matrix::Tools::Uploadable
      include Matrix::Tools::Unzipable
      include Matrix::Tools::TimeParsable

      def initialize
        @config = {}.merge(default_config)
        @answers = []
      end

      def hack
        raw = download(@config[:url], net_params)
        parse(unzip(raw, names: file_names))
        routes.each do |route|
          @answers << upload(@config[:url], net_params.merge(route))
        end
      end

      private

      def source
        self.class.name.downcase.split('::').last.to_sym
      end

      def file_names
        raise "Should be implemented"
      end

      def routes
        raise "Should be implemented"
      end

      def net_params
        { passphrase: @config[:passphrase], source: source }
      end
    end
  end
end
