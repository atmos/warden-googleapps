require 'warden'
require 'tmpdir'
require 'openid/consumer'
require 'openid/store/filesystem'
require 'openid/extensions/sreg'
require 'openid/extensions/ax'

module Warden
  module GoogleApps
    class GoogleAppsMisconfiguredError < StandardError; end
  end
end

require File.dirname(__FILE__)+'/warden-googleapps/user'
require File.dirname(__FILE__)+'/warden-googleapps/version'
require File.dirname(__FILE__)+'/warden-googleapps/strategy'
require File.dirname(__FILE__)+'/warden-googleapps/gapps_openid'
