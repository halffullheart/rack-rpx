%w(rubygems net/http net/https rack json).each { |gem| require gem }
module Rack #:nodoc:
  
  # Rack Middleware for integrating RPX Now into your application
  #
  # Note: this *requires* that a Rack::Session middleware be enabled
  #
  class Rpx
    OPTIONS = {
      :login_path      => '/login',
      :callback_path   => '/login_completed',
      :host            => 'localhost',
      :port            => '80',
      :rack_session    => 'rack.session'
    }

    # Helper methods intended to be included in your Rails controller or 
    # in your Sinatra helpers block
    module Methods
      RPX_LOGIN_URL = "https://rpxnow.com/api/v2/auth_info"
      
      # This is *the* method you want to call.
      #
      # After you're authorized and redirected back to your #redirect_to path, 
      # you should be able to call get_access_token to get and hold onto 
      # the access token for the user you've been authorized as.
      # 
      # You can use the token to make GET/POST/etc requests
      def get_credentials(token)
        u = URI.parse(RPX_LOGIN_URL)
        req = Net::HTTP::Post.new(u.path)
        req.set_form_data({:token => token, :apiKey => OPTIONS[:api_key], :format => 'json', :extended => 'true'})
        http = Net::HTTP.new(u.host,u.port)
        http.use_ssl = true if u.scheme == 'https'
        json = JSON.parse(http.request(req).body)
        
        raise LoginFailedError, 'Cannot log in. Try another account!' unless json['stat'] == 'ok'
        json
      end

      def login_widget_url(app_name)
        "https://#{app_name}.rpxnow.com/openid/v2/signin?token_url=#{callback_url}"
      end
      
      
      def callback_url
        "http://#{OPTIONS[:host]}:#{OPTIONS[:port]}#{OPTIONS[:callback_path]}"
      end
    end

    def initialize app, *args
      @app = app     
      arg_options = args.pop
      OPTIONS.merge! arg_options      
    end
    
    def call env
      @app.call(env)     
    end    
  end 
end
