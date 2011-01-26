module EwSqlMetrics
  mattr_accessor :mute_regexp
  @@mute_regexp = nil

  class MuteMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      if EwSqlMetrics.mute_regexp && env["PATH_INFO"] =~ EwSqlMetrics.mute_regexp
        EwSqlMetrics.mute!{ @app.call(env) }
      else
        @app.call(env)
      end
    end
  end
end

module EwSqlMetrics
  def self.mute!
    Thread.current["sql_metrics.mute"] = true
    yield
  ensure
    Thread.current["sql_metrics.mute"] = false
  end

  def self.mute?
    Thread.current["sql_metrics.mute"] || false
  end
end
