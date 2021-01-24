require "rack/test"
require_relative "./spec_helper"
require_relative "../app"

describe "App" do
  include Rack::Test::Methods

  def app
    # @app ||= Sinatra::Application
    @app ||= App
  end

  describe "Routes" do
    describe "GET /ping" do
      before { get "/ping" }
      it { expect(last_response).to be_ok }
      it { expect(last_response.body).to eq("pong") }
    end
  end
end
