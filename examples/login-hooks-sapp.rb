require 'rubygems'
require 'sinatra'
require 'rack'
require 'haml'
require 'lib/rack-rpx'

use Rack::Session::Cookie
 
use Rack::Rpx, :port => '9393',
               :api_key => '5b17163d199813f86e51fc3282ffc4298a40cc44',
               :callback_path => '/login_completed'
 
helpers do
  include Rack::Rpx::Methods
end

class Rack::Rpx
  def login(env)
    puts "logging in ..."   
    env['rack.session']['user']= Rack::Rpx.credentials @req.params['token']
  end
  
  def logout(env)
    puts "logging out ..."
    env['rack.session'].delete 'user'
  end  
end

get "/" do
  "our current session =>  #{session.inspect}, params => #{params.inspect}<br/>, #{env.inspect}"
end

get "/login" do
  haml :login
end

post "/login_completed" do  
  "our current #{session.inspect}"
end

get '/logout' do
  "our current #{session.inspect}"
end




