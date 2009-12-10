%w(net/http net/https rubygems rack).each { |gem| require gem }
 
module Rack #:nodoc:
  
  # Rack Middleware for integrating RPX Now into your application
  #
  # Note: this *requires* that a Rack::Session middleware be enabled
  #
  class Rpx
 
    # Helper methods intended to be included in your Rails controller or 
    # in your Sinatra helpers block
    module Methods
      RPX_NOW_URL = 'https://rpxnow.com/api/v2/auth_info'
      API_KEY     = '5b17163d199813f86e51fc3282ffc4298a40cc44'
      
      DEFAULT_OPTIONS = {
        :login_path    => '/oauth_login',
        :callback_path => '/oauth_callback',
        :redirect_to   => '/oauth_complete',
        :rack_session  => 'rack.session'
      }
      
      # This is *the* method you want to call.
      #
      # After you're authorized and redirected back to your #redirect_to path, 
      # you should be able to call get_access_token to get and hold onto 
      # the access token for the user you've been authorized as.
      #
      # You can use the token to make GET/POST/etc requests
      def get_access_token(token)
        u = URI.parse(RPX_NOW_URL)
        req = Net::HTTP::Post.new(u.path)
        req.set_form_data({:token => token, :apiKey => API_KEY, :format => 'json', :extended => 'true'})
        http = Net::HTTP.new(u.host,u.port)
        http.use_ssl = true if u.scheme == 'https'
        json = JSON.parse(http.request(req).body)
        
        raise LoginFailedError, 'Cannot log in. Try another account!' unless json['stat'] == 'ok'
        json
      end 
    end
    
    def call env
      # put this instance of Rack::OAuth in the env 
      # so it's accessible from the application
      env['rack.rpx'] ||= {}
      env['rack.rpx'][name] = self
      @app.call(env)
    end    
  end
 
end
