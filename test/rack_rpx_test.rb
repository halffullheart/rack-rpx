require File.expand_path(File.dirname(__FILE__) + '/test_helper')
require 'rack/test'


class RackRpxTest < Test::Unit::TestCase
  include Rack::Test::Methods
  
  def app
    app = Rack::Builder.app do
      use Rack::Rpx, :port => '9393',
        :api_key => '5b17163d199813f86e51fc3282ffc4298a40cc44',
        :callback_path => '/login_completed'
      lambda { |env| [200, {'Content-Type' => 'text/plain'}, 'OK'] }
    end
  end

  def test_redirect_logged_in_users_to_dashboard
    get "/"

    assert_equal "http://localhost:9393/login_completed", last_request.url
    assert last_response.ok?
  end

end
