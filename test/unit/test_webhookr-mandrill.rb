
$: << File.join(File.dirname(__FILE__), "..")
require 'test_helper'

describe Webhookr::Mandrill::Adapter do
  
  before do
    @fired_at = "2009-03-26 22:01:00"
    @event_type = "spam"
    @single_response = '{ "event": "' + @event_type + '", "ts": "' + @fired_at + '", "msg": { "email": "gerry%2Bagent1@zoocasa.com" }} '
    @valid_response = 'mandrill_events=[' + @single_response + ']' 
    @valid_responses = 'mandrill_events=[' + @single_response + ',' + @single_response + ']' 
  end

  describe "the class" do

    subject { Webhookr::Mandrill::Adapter }

    it "must support process" do
      subject.must_respond_to(:process)
    end

  end

  describe "the instance" do

    subject { Webhookr::Mandrill::Adapter.new }

    it "should not return an error for a valid packet" do
      lambda {
        subject.process(@valid_response)
      }.must_be_silent
    end

    it "should raise Webhookr::InvalidPayloadError for no packet" do
      lambda {
        subject.process("")
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing event type" do
      lambda {
        subject.process('mandrill_events=[ { "msg": { "email": "gerry%2Bagent1@zoocasa.com" }} ]')
      }.must_raise(Webhookr::InvalidPayloadError)
    end

    it "should raise Webhookr::InvalidPayloadError for a missing data packet" do
      lambda {
        subject.process('mandrill_events=[ { "event": "spam" } ]')
      }.must_raise(Webhookr::InvalidPayloadError)
    end

  end

  describe "it's response" do
    before do
      @adapter = Webhookr::Mandrill::Adapter.new
    end

    subject { @adapter.process(@valid_response).first }

    it "must respond to service_name" do
      subject.must_respond_to(:service_name)
    end

    it "should return the correct service name" do
      assert_equal(Webhookr::Mandrill::Adapter::SERVICE_NAME, subject.service_name)
    end

    it "must respond to event_type" do
      subject.must_respond_to(:event_type)
    end

    it "should return the correct event type" do
      assert_equal(@event_type, subject.event_type)
    end

    it "must respond to payload" do
      subject.must_respond_to(:payload)
    end

    it "must respond to payload.msg" do
      subject.payload.must_respond_to(:msg)
    end

    it "should return the correct data packet" do
      assert_equal("gerry+agent1@zoocasa.com", subject.payload.msg.email)
    end
  end

end
