require "json"
require "sinatra/base"
require "sinatra/reloader"
require "sinatra/namespace"
# require "sinatra/config_file"
# require "active_support/core_ext/hash/keys"
# require "active_support/core_ext/numeric/time"
# require "hamlit"

class AppError < StandardError; end

class App < Sinatra::Base
  register Sinatra::Namespace
  # register Sinatra::ConfigFile

  # config_file "./config.yml"

  configure :production, :development do
    enable :logging
  end

  configure :development do
    register Sinatra::Reloader
  end

  # set :server, :puma
  # set :server, :falcon
  # set :bind, "0.0.0.0"
  # set :port, ENV["PORT"] || 4567
  set :protection, true
  set :sessions, true
  set :inline_templates, true
  # set(:development) { |value| condition { value && App.development? } }

  # use Rack::Auth::Basic do |username, password|
  #   username == "hoge" && password == "fuga"
  # end

  use Rack::Session::Pool

  helpers do
  end

  not_found do
    puts env["sinatra.error"].message
    "404 Page Not Found."
  end

  before do
  end

  get "/ping" do
    "pong"
  end

  get "/" do
    # haml :index
    "hello"
  end

  namespace "/admin" do
    # before do
    #   return 403 unless App.development?
    # end

    get "/" do
      "hello admin"
    end
  end

  namespace "/api" do
    get "/health" do
      "ok"
    end

    namespace "/v1" do
      get "/ping" do
        "pong"
      end
    end
  end

  # run! if app_file == $0
end
