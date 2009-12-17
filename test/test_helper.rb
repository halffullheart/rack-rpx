$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'rack-rpx'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'
require 'test/spec'

