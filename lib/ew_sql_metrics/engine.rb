module EwSqlMetrics
  class Engine < Rails::Engine
    # Insert the mute middleware high in the stack to ensure
    # no queries in the stack will escape the mute
    config.app_middleware.insert_after "ActionDispatch::Callbacks", "EwSqlMetrics::MuteMiddleware"
    config.app_middleware.insert_after "Warden::Manager", "EwSqlMetrics::UserSessionMiddleware"
    # Make configurations proxy to SqlMetrics module
    config.ew_sql_metrics = EwSqlMetrics
  end
end