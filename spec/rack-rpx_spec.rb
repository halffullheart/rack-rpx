require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'rack/test'

describe Rack::Rpx, "basics" do  
  include Rack::Test::Methods

  before do
    @lambda  = lambda {|env| [200, {}, ["Hello World"]] }
  end

  def app       ; @app      ; end
  def app=(app) ; @app= app ; end
  

  # TODO remove OPTIONS const, is just horrible
  it 'should have a name' do
    app = Rack::Rpx.new @lambda, :key => 'b', :secret => 'c', :name => 'olokun'
    app.name.should == 'olokun'
  end

  it 'name should default to "default"' do
    app= Rack::Rpx.new @lambda,  :key => 'b', :secret => 'c'
    app.name.should == 'default'
  end

  it 'should be able to access an instance of Rack::Rpx by name from within Rack application' do
    app = Rack::Rpx lambda {|env| [200, {}, [ env['rack.oauth'].keys.inspect ]] }, :key => 'b', :secret => 'c'
    
    #rpx = Rack::Rpx.new @app, :key => 'b', :secret => 'c', :name => 'olokun'
    get "/"
    
    last_response.body.should contain("olokun")
    
  end
  
end
