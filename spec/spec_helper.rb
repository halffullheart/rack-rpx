$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rack-rpx'
require 'spec'
require 'spec/autorun'
require 'rackbox'
require File.dirname(__FILE__) + '/../lib/rack-rpx'

RackBox.app = lambda {}
Spec::Runner.configure do |config|
  config.use_blackbox = true  
end
 
# returns the path to a data file, eg. data_path(:foo) => 'spec/data/foo.yml'
def data_path name
  File.join File.dirname(__FILE__), 'data', "#{name}.yml"
end
 
# returns the string body of a file using data_path to get the path to the file
def data name
  File.read data_path(name)
end
 
def mock_request_token options = {}
  YAML.load data(:unauthorized_request_token).sub('AUTH_PATH', options[:authorize_path] || '/oauth/authorize')
end
 
