require "rubygems"
require "bundler"
Bundler.require(:default)

require "CGI"

module Webhookr
  module Mandrill
    class Adapter
      SERVICE_NAME = "mandrill"
      EVENT_KEY = "event"
      PAYLOAD_KEY = "msg"
      
      include Webhookr::Services::Adapter::Base

      def self.process(raw_response)
        new.process(raw_response)
      end

      def process(raw_response)
        Array.wrap(parse(raw_response)).collect do |p|
          Webhookr::AdapterResponse.new(
            SERVICE_NAME, p.fetch(EVENT_KEY), RecursiveOpenStruct.new(p)
          ) if assert_valid_packet(p)
        end
      end

      private

      def parse(raw_response)
        begin
          assert_valid_packets(
            ActiveSupport::JSON.decode(
              CGI.unescape(raw_response).gsub(/mandrill_events=/,"")
            )
          )
        rescue Exception => e
          raise InvalidPayloadError.new(e)
        end
      end

      def assert_valid_packets(parsed_responses)
        raise(
          Webhookr::InvalidPayloadError, "Malformed response |#{parsed_responses.inspect}|"
        ) unless parsed_responses.is_a?(Array) && parsed_responses.first.is_a?(Hash)
        parsed_responses
      end

      def assert_valid_packet(packet)
        raise(Webhookr::InvalidPayloadError, "Unknown event #{packet[EVENT_KEY]}") unless packet[EVENT_KEY]
        raise(Webhookr::InvalidPayloadError, "No msg in the response") unless packet[PAYLOAD_KEY]
        true
      end

    end
  end
end
