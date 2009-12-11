require 'rubygems'
require 'sinatra'
require 'rack'
require 'haml'
require 'lib/rack-rpx'

use Rack::Session::Cookie
 
use Rack::Rpx, :api_key => '5b17163d199813f86e51fc3282ffc4298a40cc44',
               :callback_path => 'login_completed' 

 
helpers do
  include Rack::Rpx::Methods
end

get "/" do
  "our current session =>  #{session.inspect}, params => #{params.inspect}"
end

get "/login" do
  haml :login
end

post "/login_completed" do  
  "our current #{get_credentials(params[:token])}"
end






