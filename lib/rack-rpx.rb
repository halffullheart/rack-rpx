%w(rubygems net/http net/https rack json).each { |gem| require gem }
module Rack #:nodoc:
  
  # Rack Middleware for integrating RPX Now into your application
  #
  # Note: this *requires* that a Rack::Session middleware be enabled
  #
  class Rpx
    RPX_LOGIN_URL = "https://rpxnow.com/api/v2/auth_info"
    # Raised if an incompatible session is being used.
    class NoSession        < RuntimeError; end
    class LoginFailedError < RuntimeError; end
    
    OPTIONS = {
      :callback_path   => '/login_completed',
      :logout_path     => '/logout', 
      :host            => 'localhost',
      :port            => '80',
      :rack_session    => 'rack.session',
      :name            => 'default'
    }
    
    # Helper methods intended to be included in your Rails controller or 
    # in your Sinatra helpers block
    module Methods

      # This is *the* method you want to call.
      #
      # After you're authorized and redirected back to your #redirect_to path, 
      # you should be able to call get_access_token to get and hold onto 
      # the access token for the user you've been authorized as.
      # 
      # You can use the token to make GET/POST/etc requests
      def get_credentials(token)
        Rack::Rpx.get_credentials(token)
      end

      def login_widget_url(app_name=nil)
        "https://#{app_name}.rpxnow.com/openid/v2/signin?token_url=#{callback_url}"
      end      
      
      def callback_url
        "http://#{env['HTTP_HOST']}#{OPTIONS[:callback_path]}"
      end
    end

    class << self
      def credentials(token)
        u = URI.parse(RPX_LOGIN_URL)
        req = Net::HTTP::Post.new(u.path)
        req.set_form_data({:token => token, :apiKey => OPTIONS[:api_key], :format => 'json', :extended => 'true'})
        http = Net::HTTP.new(u.host,u.port)
        http.use_ssl = true if u.scheme == 'https'
        json = JSON.parse(http.request(req).body)
        
        raise LoginFailedError, 'Cannot log in. Try another account! #{json.inspect}' unless json['stat'] == 'ok'
        json
      end
    end
    
    def initialize app, *options
      @app = app
      OPTIONS.merge! options.pop
      OPTIONS.each do |k,v|
        Rack::Rpx.send(:define_method, k.to_s) {OPTIONS[k]}
      end      
    end
    
    def call env      
      @req = Rack::Request.new env 
      raise NoSession, 'No compatible session.' unless env['rack.session']
      
      if env['PATH_INFO'] ==  OPTIONS[:callback_path] &&  @req.post? then 
        token = @req.params["token"]
        set_credentials(env, token) if OPTIONS[:set_credentials] 
        login(env)
      elsif env['PATH_INFO'] == OPTIONS[:logout_path] then
        logout(env)
      end        
      @app.call(env)     
    end

    def set_credentials(env, token)
      env['rack.session']['credentials'] = self.get_credentials(token)
    end

    # This is the method that you should override if you want to
    # perform any operation just after the response from rpx now
    # 
    # You can use the token to make GET/POST/etc requests
    def login(env);  end


    # This is the method that you should override if you want to
    # perform any operation just before you reach the logout_path
    def logout(env); end
    
  end 
end
