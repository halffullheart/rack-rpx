$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'rack-rpx'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'

# set test environment
# set :environment, :test
# set :run, false
# set :raise_errors, true
# set :logging, false

# I dont know 
def mock_request_token options = {}
  YAML.load data(:unauthorized_request_token).sub('AUTH_PATH', options[:authorize_path] || '/oauth/authorize')
end
 
