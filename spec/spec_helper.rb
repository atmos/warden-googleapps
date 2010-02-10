require 'rubygems'
require 'bundler'

Bundler.setup(:runtime, :test)
Bundler.require(:runtime, :test)

require File.join(File.dirname(__FILE__), '..', 'lib', 'warden-googleapps')
require 'pp'

FakeWeb.allow_net_connect = false

Webrat.configure do |config|
  config.mode = :rack
  config.application_port = 4567
end

Spec::Runner.configure do |config|
  config.include(Rack::Test::Methods)

  config.before(:each) do
    FakeWeb.clean_registry
  end

  def app
    lambda do |env|
      [ 200, { }, 'Hello!' ]
    end
  end
end
