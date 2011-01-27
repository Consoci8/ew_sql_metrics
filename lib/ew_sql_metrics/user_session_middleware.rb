module EwSqlMetrics
  mattr_accessor :curr_user
  @@curr_user = nil
  
  class UserSessionMiddleware
    def initialize(app)
      @app = app
    end
    
    def call(env)
      status, headers, body = @app.call(env)
      
      if !env["warden"].nil?
        EwSqlMetrics.curr_user = env["warden"].user
        [status, headers, body]
      else
        [status, headers, body]
      end
    end
  end
end