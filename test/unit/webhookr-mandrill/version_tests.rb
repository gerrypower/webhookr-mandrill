$: << File.join(File.dirname(__FILE__), %w{ .. .. })
require 'test_helper'

describe Webhookr::Mandrill do
  it "must be defined" do
    Webhookr::Mandrill::VERSION.wont_be_nil
  end
end