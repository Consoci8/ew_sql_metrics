module EwSqlMetrics
  mattr_accessor :curr_user
  @@curr_user = nil
  
  class UserSessionMiddleware
    def initialize(app)
      @app = app
    end
    
    def call(env)
      EwSqlMetrics.curr_user = env["warden"].user
      @app.call(env)
    end
  end
end