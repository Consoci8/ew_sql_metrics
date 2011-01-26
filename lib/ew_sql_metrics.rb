require "mongoid"
require "ew_sql_metrics/engine"
require "ew_sql_metrics/mute_middleware"

# We are required to choose a database name
Mongoid.configure do |config|
  name = "ew_sql_metrics-#{Rails.env}"
  host = "localhost"
  config.master = Mongo::Connection.new.db(name)
  config.persist_in_safe_mode = false
end

require "active_support/notifications"
ActiveSupport::Notifications.subscribe /^sql\./ do |*args|
  EwSqlMetrics::Metric.store!(args) unless EwSqlMetrics.mute?
end